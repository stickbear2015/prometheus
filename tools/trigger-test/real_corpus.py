"""Pick real example lines from a MUSHclient game log, for realistic tests.

    python -I real_corpus.py <plugin.xml> <game log> <out corpus>

For each trigger it keeps a handful of distinct real lines that fire it, plus
lines containing each text the trigger's code checks for, so the many branches
inside big triggers get real examples too.

The output contains other players' names and chat. Keep it in temp-logs/
(git-ignored) and never commit it.
"""
import os
import re
import sys
import time
import zlib

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import mushtrig  # noqa: E402
from gen_corpus import literals_for_wildcards  # noqa: E402

PER_TRIGGER = 8      # distinct lines kept for each trigger
PER_LITERAL = 3      # lines kept for each text a trigger's code checks for


def main():
    plugin, log_path, out_path = sys.argv[1:4]
    triggers = mushtrig.load_triggers(plugin)
    order = mushtrig.ordered(triggers)
    lits = {t.index: [(n, l.lower()) for n, ls in literals_for_wildcards(t.send).items() for l in ls if l.strip()]
            for t in triggers}

    # One combined pattern finds lines that match any trigger at all, quickly.
    alts = []
    for t in order:
        pat = t.regex.pattern
        flags = "(?i:" if t.ignore_case else "(?:"
        alts.append(flags + pat + ")")
    try:
        anyre = re.compile("|".join(alts))
    except re.error:
        anyre = None

    start = time.time()
    seen = set()
    kept = {}        # trigger index -> list of lines
    kept_lit = {}    # (trigger index, wildcard, literal) -> list of lines
    rows = []
    n = 0
    with open(log_path, encoding="latin-1", errors="replace") as fh:
        for raw in fh:
            n += 1
            line = raw.rstrip("\r\n")
            if not line or len(line) > 400:
                continue
            h = zlib.crc32(line.encode("latin-1", "replace"))
            if h in seen:
                continue
            seen.add(h)
            if anyre is not None and not anyre.search(line):
                continue
            fired = mushtrig.fire(order, line)
            if not fired:
                continue
            t, m = fired[0]
            keep = False
            bucket = kept.setdefault(t.index, [])
            if len(bucket) < PER_TRIGGER:
                bucket.append(line)
                keep = True
            for wn, lit in lits.get(t.index, []):
                try:
                    val = (m.group(wn) or "").lower()
                except IndexError:
                    continue
                if lit in val:
                    b = kept_lit.setdefault((t.index, wn, lit), [])
                    if len(b) < PER_LITERAL:
                        b.append(line)
                        keep = True
            if keep:
                rows.append(line)
            if n % 1000000 == 0:
                print("%d lines read, %d unique, %d kept, %.0fs" % (n, len(seen), len(rows), time.time() - start), flush=True)

    with open(out_path, "w", encoding="utf-8", newline="\n") as out:
        for i, line in enumerate(rows, start=1):
            out.write("r%d\t-\t%s\n" % (i, line))
    print("done: %d lines read, %d unique, %d kept for %d triggers, %.0fs" % (
        n, len(seen), len(rows), len(kept), time.time() - start))


if __name__ == "__main__":
    main()
