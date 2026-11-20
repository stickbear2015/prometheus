"""Build the test corpus: sample game lines that exercise the pack's triggers.

Run once from the ORIGINAL plugin, so the corpus reflects today's behaviour:
    python -I gen_corpus.py <plugin.xml> <lua folder> <corpus.txt>

Each line of corpus.txt is:  id <TAB> settings <TAB> game line
where settings is "-" or a comma list like "SalvagingMessages=1".
"""
import glob
import json
import re
import sys
import re._parser as sre_parse
import re._constants as C

sys.path.insert(0, __import__('os').path.dirname(__import__('os').path.abspath(__file__)))
import mushtrig  # noqa: E402

FILL = "Someone"


def lua_literal_to_text(s):
    """Turn a Lua pattern literal into plain text (drop % escapes and anchors)."""
    s = re.sub(r"\\(.)", r"\1", s)   # Lua string escapes such as \- or \.
    s = re.sub(r"%(.)", r"\1", s)    # Lua pattern escapes such as %-
    return s.strip("^$")


def literals_for_wildcards(code):
    """Map wildcard number -> literal strings the send code checks it against."""
    found = {}
    pats = [
        r'string\.match\(\s*(?:string\.lower\()?\s*"%(\d)"\s*\)?\s*,\s*"((?:[^"\\]|\\.)*)"',
        r'"%(\d)"\s*==\s*"((?:[^"\\]|\\.)*)"',
        r'string\.find\(\s*(?:string\.lower\()?\s*"%(\d)"\s*\)?\s*,\s*"((?:[^"\\]|\\.)*)"',
    ]
    for p in pats:
        for n, lit in re.findall(p, code):
            found.setdefault(int(n), []).append(lua_literal_to_text(lit))
    return found


def settings_used(code, defaults):
    out = []
    for name in sorted(set(re.findall(r"ConfigTable\.Settings\.(\w+)", code))):
        v = defaults.get(name)
        if v in (0, 1):
            out.append("%s=%d" % (name, 1 - v))
    return out


def gen_regex(pattern, flags, fills):
    """Generate one string matching a (simple) regex, filling groups from `fills`."""
    try:
        tree = sre_parse.parse(pattern, flags)
    except Exception:
        return None
    group_values = {}

    def walk(items):
        s = ""
        for op, av in items:
            if op == C.LITERAL:
                s += chr(av)
            elif op == C.NOT_LITERAL:
                s += "x" if chr(av) != "x" else "y"
            elif op == C.ANY:
                s += "x"
            elif op == C.IN:
                s += in_class(av)
            elif op == C.AT:
                pass
            elif op == C.SUBPATTERN:
                gid = av[0]
                if gid is not None and gid in fills:
                    v = fills[gid]
                else:
                    v = walk(av[3])
                if gid is not None:
                    group_values[gid] = v
                s += v
            elif op == C.BRANCH:
                s += walk(av[1][0])
            elif op in (C.MAX_REPEAT, C.MIN_REPEAT, C.POSSESSIVE_REPEAT):
                lo, hi, sub = av
                # a "match anything" repeat gets a readable word; others repeat once
                if len(sub) == 1 and sub[0][0] in (C.ANY, C.NOT_LITERAL) or (len(sub) == 1 and sub[0][0] == C.IN and lo == 0):
                    s += FILL if lo <= 1 else FILL * lo
                else:
                    s += walk(sub) * max(lo, 1)
            elif op == C.GROUPREF:
                s += group_values.get(av, "")
            elif op == C.ASSERT or op == C.ASSERT_NOT:
                pass
            else:
                s += "x"
        return s

    def in_class(items):
        for op, av in items:
            if op == C.LITERAL:
                return chr(av)
            if op == C.RANGE:
                return chr(av[0])
            if op == C.CATEGORY:
                return {"CATEGORY_DIGIT": "5", "CATEGORY_SPACE": " ", "CATEGORY_WORD": "a"}.get(str(av), "a")
        return "a"

    return walk(tree)


def main():
    plugin, luadir, out_path = sys.argv[1:4]
    defaults = {}
    cfg = open(glob.glob(luadir + "/prometheus/core/config.lua")[0], encoding="latin-1").read()
    for name, v in re.findall(r"ConfigTable\.Settings\.(\w+)\s*=\s*(\d+)\s*$", cfg, re.M):
        defaults.setdefault(name, int(v))

    triggers = mushtrig.load_triggers(plugin)
    order = mushtrig.ordered(triggers)
    rows = []
    seen = set()

    def add(line, settings="-"):
        key = (line, settings)
        if line and key not in seen:
            seen.add(key)
            rows.append((settings, line))

    for t in triggers:
        if not t.regex:
            continue
        code = t.send
        lits = literals_for_wildcards(code)
        ngroups = t.regex.groups
        variants = [{}]
        for n, values in lits.items():
            for v in values:
                variants.append({n: v})
            variants.append({n: " ".join(values)})
        for v in variants:
            fills = {i: v.get(i, FILL) for i in range(1, ngroups + 1)}
            if t.is_regexp:
                line = gen_regex(t.match, re.IGNORECASE if t.ignore_case else 0, fills)
            else:
                parts = t.match.split("*")
                line = parts[0]
                for i, p in enumerate(parts[1:], start=1):
                    line += fills.get(i, FILL) + p
            if line is None or not t.regex.search(line):
                continue
            add(line)
            for s in settings_used(code, defaults):
                add(line, s)

    # #$#soundpack out-of-band lines handled in sounds.lua (OnOOBmsg).
    for f in glob.glob(luadir + "/prometheus/**/*.lua", recursive=True):
        src = open(f, encoding="latin-1").read()
        for lit in re.findall(r'line\s*==\s*"(#\$#soundpack[^"]*)"', src):
            add(lit)
        for a in re.findall(r'string\.match\(\s*line\s*,\s*"((?:[^"\\]|\\.)*)"', src):
            add("#$#soundpack misc | " + lua_literal_to_text(a))

    with open(out_path, "w", encoding="utf-8", newline="\n") as fh:
        for i, (settings, line) in enumerate(rows, start=1):
            fh.write("%d\t%s\t%s\n" % (i, settings, line))
    print("wrote %d lines" % len(rows))


if __name__ == "__main__":
    main()
