"""Look for two kinds of text checks that can never match, across the pack's Lua.

    python -I check_patterns.py <pack folder>

1. A capital letter in text looked for in a lowercased line, for example
   string.match(string.lower(x), "Weapon fire") or has_lower = "Weapon fire".
2. A plain "-" in text looked for with string.match, for example "self-destruct".
   In Lua patterns "-" means "repeat the previous character, as few times as
   possible", so "self-destruct" doesn't find the words self-destruct. Write "%-".
   (Some hyphens happen to work, such as "X-Loritan", which really finds "Loritan";
   those are listed too, marked "works by luck".)
"""
import glob
import os
import re
import sys


def hyphen_works_by_luck(pat):
    """True if the pattern with its "x-" removed finds the same words anyway, roughly:
    the character before the hyphen can be skipped (X-Loritan -> Loritan)."""
    return bool(re.fullmatch(r"[A-Z]-\w+", pat))


def main():
    pack = sys.argv[1]
    found = 0
    for src in sorted(glob.glob(os.path.join(pack, "lua", "prometheus", "**", "*.lua"), recursive=True)):
        rel = os.path.relpath(src, pack)
        for n, ln in enumerate(open(src, encoding="latin-1"), start=1):
            code = ln.split("--", 1)[0] if not ln.lstrip().startswith("--") else ""
            # 1. capitals in lowercased checks
            for pat in re.findall(r'string\.match\(\s*string\.lower\([^)]*\)\s*,\s*"([^"]*)"', code):
                if re.search(r"[A-Z]", pat.replace("%A", "").replace("%S", "")):
                    print("%s:%d  capital in a lowercased check: %r" % (rel, n, pat)); found += 1
            for m in re.finditer(r'\b(has_lower|any_lower|channel_lower)\s*=\s*(\{[^}]*\}|"[^"]*")', code):
                for pat in re.findall(r'"([^"]*)"', m.group(2)):
                    if re.search(r"[A-Z]", pat):
                        print("%s:%d  capital in a lowercased check: %r" % (rel, n, pat)); found += 1
            # 2. unescaped hyphens in text looked for with string.match or in list checks
            pats = re.findall(r'string\.match\([^,]*,\s*"([^"]*)"', code)
            for m in re.finditer(r'\b(has|has_lower|any|any_lower|channel|channel_lower|message)\s*=\s*(\{[^}]*\}|"[^"]*")', code):
                pats += re.findall(r'"([^"]*)"', m.group(2))
            for pat in pats:
                if re.search(r"(?<!%)-", pat) and not re.search(r"\[[^\]]*-[^\]]*\]", pat):
                    luck = " (works by luck)" if hyphen_works_by_luck(pat) else ""
                    print("%s:%d  plain hyphen%s: %r" % (rel, n, luck, pat)); found += 1
    print("%d found" % found)


if __name__ == "__main__":
    main()
