"""One-off: replace pairs of history_add lines with AddToHistory (issue #44).

    python -I use_history_helper.py <pack folder>

Turns
    Execute("history_add All=Computer Reports: " .. text)
    Execute("history_add Computer Reports=" .. text)
into
    AddToHistory("Computer Reports", text, "Computer Reports: " .. text)
The commands sent are exactly the same. Pairs whose buffer name isn't plain text
(worked out from the channel) are left alone.
"""
import glob
import os
import re
import sys

LINE = re.compile(r'^(\s*)Execute\("history_add ([^"=]*)=(.*)\)\s*$')


def rest_expr(after_eq):
    """The value after 'name=' as a Lua expression: after_eq is the rest of the string
    literal and what follows, for example 'Computer Reports: " .. text'."""
    expr = '"' + after_eq
    if expr.startswith('"" .. '):
        expr = expr[len('"" .. '):]
    return expr


def main():
    pack = sys.argv[1]
    total = 0
    for path in glob.glob(os.path.join(pack, "lua", "prometheus", "triggers", "*.lua")):
        if path.endswith("common.lua"):
            continue
        lines = open(path, encoding="latin-1").read().split("\n")
        out, i, n = [], 0, 0
        while i < len(lines):
            a = LINE.match(lines[i])
            b = LINE.match(lines[i + 1]) if i + 1 < len(lines) else None
            if a and b and a.group(2) == "All" and b.group(2) not in ("", "All"):
                indent = a.group(1)
                all_text = rest_expr(a.group(3))
                text = rest_expr(b.group(3))
                buffer = '"%s"' % b.group(2)
                if all_text == text:
                    out.append('%sAddToHistory(%s, %s)' % (indent, buffer, text))
                else:
                    out.append('%sAddToHistory(%s, %s, %s)' % (indent, buffer, text, all_text))
                i += 2
                n += 1
                continue
            out.append(lines[i])
            i += 1
        if n:
            open(path, "w", encoding="latin-1", newline="\n").write("\n".join(out))
            print("%-16s %d pairs" % (os.path.basename(path), n))
            total += n
    print("total %d" % total)


if __name__ == "__main__":
    main()
