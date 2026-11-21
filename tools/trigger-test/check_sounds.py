"""Check that every sound the pack's code can play actually exists.

    python -I check_sounds.py <pack folder>

Reads every PlayGlobalSound, PlayCombatSound and PlayRoomSound call in the pack's Lua
and plugin files. Fixed names are checked directly. For "Beep" .. math.random(1, 5)
every number in the range is checked. Parts that depend on the game's text (wildcards,
variables) become "anything", and at least one file must fit. File names are compared
without regard to case, as Windows does.

Prints each missing sound with where it's played from.
"""
import glob
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import luascan  # noqa: E402

BASES = {"PlayGlobalSound": "", "PlayCombatSound": "Combat/", "PlayRoomSound": "Rooms/"}


def call_argument(code, start):
    """Return the text of the first argument of the call whose '(' is at start."""
    depth, i = 0, start
    in_str = None
    while i < len(code):
        c = code[i]
        if in_str:
            if c == "\\":
                i += 2
                continue
            if c == in_str:
                in_str = None
        elif c in "\"'":
            in_str = c
        elif c == "(":
            depth += 1
        elif c == ")":
            depth -= 1
            if depth == 0:
                return code[start + 1:i]
        elif c == "," and depth == 1:
            return code[start + 1:i]
        i += 1
    return None


def expand(arg):
    """Turn a path expression into a list of glob patterns (None if it can't be read)."""
    parts = [p.strip() for p in split_concat(arg)]
    patterns = [""]
    for p in parts:
        m = re.fullmatch(r'"((?:[^"\\]|\\.)*)"', p) or re.fullmatch(r"'((?:[^'\\]|\\.)*)'", p)
        r = re.fullmatch(r"math\.random\(\s*(-?\d+)\s*(?:,\s*(-?\d+)\s*)?\)", p)
        if m:
            patterns = [x + m.group(1) for x in patterns]
        elif r:
            a, b = (1, int(r.group(1))) if r.group(2) is None else (int(r.group(1)), int(r.group(2)))
            if b - a > 200:
                return None
            patterns = [x + str(n) for x in patterns for n in range(a, b + 1)]
        else:
            patterns = [x + "*" for x in patterns]
    return patterns


def split_concat(expr):
    """Split a Lua expression on top-level '..'."""
    out, buf, depth, i, in_str = [], [], 0, 0, None
    while i < len(expr):
        c = expr[i]
        if in_str:
            buf.append(c)
            if c == "\\" and i + 1 < len(expr):
                buf.append(expr[i + 1])
                i += 2
                continue
            if c == in_str:
                in_str = None
        elif c in "\"'":
            in_str = c
            buf.append(c)
        elif c in "([{":
            depth += 1
            buf.append(c)
        elif c in ")]}":
            depth -= 1
            buf.append(c)
        elif expr.startswith("..", i) and depth == 0:
            out.append("".join(buf))
            buf = []
            i += 2
            continue
        else:
            buf.append(c)
        i += 1
    out.append("".join(buf))
    # strip wrapping brackets like ("a" .. b)
    cleaned = []
    for p in out:
        p = p.strip()
        while p.startswith("(") and p.endswith(")") and call_argument(p, 0) == p[1:-1]:
            p = p[1:-1].strip()
            if ".." in p:
                cleaned.extend(split_concat(p))
                p = None
                break
        if p is not None:
            cleaned.append(p)
    return cleaned


def main():
    pack = sys.argv[1]
    sounds = os.path.join(pack, "sounds")
    existing = set()
    for root, _, files in os.walk(sounds):
        for f in files:
            rel = os.path.relpath(os.path.join(root, f), sounds).replace("\\", "/")
            existing.add(rel.lower())
    import fnmatch
    sources = glob.glob(os.path.join(pack, "lua", "prometheus", "**", "*.lua"), recursive=True)
    sources += glob.glob(os.path.join(pack, "worlds", "plugins", "**", "*.xml"), recursive=True)
    missing, unreadable, checked = [], [], 0
    for src in sources:
        text = open(src, encoding="latin-1").read()
        code = "".join(t for k, t in luascan.pieces(text) if k != "comment") if src.endswith(".lua") else text
        for m in re.finditer(r"\b(PlayGlobalSound|PlayCombatSound|PlayRoomSound)\s*\(", code):
            if code[:m.start()].rstrip().endswith("function"):
                continue  # the definition itself
            arg = call_argument(code, m.end() - 1)
            if arg is None:
                continue
            line_no = code.count("\n", 0, m.start()) + 1
            where = "%s:%d" % (os.path.relpath(src, pack), line_no)
            pats = expand(arg)
            if pats is None or all(p.strip("*") == "" for p in pats):
                unreadable.append((where, arg.strip()))
                continue
            for p in pats:
                checked += 1
                full = (BASES[m.group(1)] + p).replace("\\", "/").lower()
                if "*" in full:
                    if not any(fnmatch.fnmatchcase(e, full) for e in existing):
                        missing.append((where, BASES[m.group(1)] + p))
                elif full not in existing:
                    missing.append((where, BASES[m.group(1)] + p))
    # Sound lists (lookup tables) such as SOCIAL_SOUNDS: one entry per line, like
    #   { word = "cheer", sound = "Socials/Cheer_", gendered = true, versions = 3 },
    for src in sources:
        if not src.endswith(".lua"):
            continue
        text = open(src, encoding="latin-1").read()
        for n, ln in enumerate(text.split("\n"), start=1):
            if ln.lstrip().startswith("--") or not re.search(r'\bsound\s*=\s*"', ln):
                continue
            # Each { ... } holding a sound is one sound spec; handle inner braces (also = { ... }) first.
            groups, rest = [], ln
            while True:
                inner = re.search(r"\{([^{}]*)\}", rest)
                if not inner:
                    break
                groups.append(inner.group(1))
                rest = rest[:inner.start()] + "\0" + rest[inner.end():]
            if not groups:
                groups = [ln]  # an entry spread over several lines: use this line alone
            for g in groups:
                m = re.search(r'\bsound\s*=\s*"([^"]+)"', g)
                if not m:
                    continue
                names = [m.group(1)]
                if re.search(r"\bgendered\s*=\s*true", g):
                    names = [x + gd for x in names for gd in ("female", "male")]
                v = re.search(r"\bversions\s*=\s*(\d+)", g)
                if v:
                    names = [x + str(i) for x in names for i in range(1, int(v.group(1)) + 1)]
                base = "Combat/" if re.search(r"\bcombat\s*=\s*true", g) else ""
                for nm in names:
                    checked += 1
                    if (base + nm + ".ogg").lower() not in existing:
                        missing.append(("%s:%d" % (os.path.relpath(src, pack), n), base + nm + ".ogg"))
    print("checked %d sound names; %d missing" % (checked, len(missing)))
    for where, p in missing:
        print("  MISSING %-45s played from %s" % (p, where))
    if unreadable:
        print("not checked (the whole name comes from the game or a variable):")
        for where, a in unreadable:
            print("  %s  %s" % (where, a))


if __name__ == "__main__":
    main()
