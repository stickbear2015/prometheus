"""Find triggers that take channel messages away from the channel trigger.

    python -I check_channel_steals.py <plugin.xml> <game log> [more logs...]

A channel message looks like "[Channel] ..." and should be handled by the channel
trigger (or by one of the triggers written for particular bracketed messages, whose
patterns start with "[", such as "[Frequency *] *"). Broad triggers whose patterns start
with "^(" are checked before the channel trigger, so if they match a channel message they
take it, and it loses its channel sound and buffers. This lists any that do.
"""
import os
import re
import sys
from collections import Counter

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import mushtrig  # noqa: E402

CHANNEL = re.compile(r"^\[([A-Za-z- ]+)\][,:]? [\"]?(.*)[\"]?$")


def main():
    plugin, logs = sys.argv[1], sys.argv[2:]
    order = mushtrig.ordered(mushtrig.load_triggers(plugin))
    steals = Counter()
    examples = {}
    seen = set()
    total = 0
    for f in logs:
        for ln in open(f, encoding="latin-1", errors="replace"):
            ln = ln.rstrip("\r\n")
            if ln in seen or not CHANNEL.search(ln):
                continue
            seen.add(ln)
            total += 1
            fired = mushtrig.fire(order, ln)
            if not fired:
                continue
            t = fired[0][0]
            if t.match.startswith("[") or t.match == CHANNEL.pattern or t.script == "Comms_ChannelMessage":
                continue  # the channel trigger, or one written for that bracketed message
            steals[t.match] += 1
            examples.setdefault(t.match, re.sub(r"[A-Z][a-z]+ [A-Z][a-z]+", "NAME", ln)[:100])
    print("checked %d different channel messages" % total)
    for m, c in steals.most_common():
        print("  %5d taken by: %s\n        e.g. %s" % (c, m[:90], examples[m]))
    if not steals:
        print("  none taken by other triggers")


if __name__ == "__main__":
    main()
