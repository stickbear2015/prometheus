"""Add #$#soundpack social test lines to corpus.txt.

These messages are hidden by the pack, so they never appear in game logs, and the
made-up corpus had none. Adds every social the pack knows, plus some it doesn't, in a
room and on a channel, for female and male characters, and once with social sounds off.
Safe to run again: lines already in the corpus are skipped.

    python -I add_social_lines.py corpus.txt
"""
import sys

KNOWN = ["pyrianSay", "belch", "burp", "cackle", "cheer", "collapse", "cough", "cry", "fart", "gag",
         "giggle", "hmm", "kick", "kiss", "laugh", "lol", "moan", "punch", "rofl", "scream", "sigh",
         "slap", "snap", "tackle", "whistle", "yawn"]
# Socials without their own entry (they fall back to Socials/<name>.ogg), names that contain a
# known word, and the stand/sit extras.
OTHER = ["wave", "nod", "cheekkiss", "scry", "stand", "sit", "standup", "situp", "chuckle", "hug"]


def main():
    path = sys.argv[1]
    rows = [ln.rstrip("\n").split("\t", 2) for ln in open(path, encoding="utf-8") if ln.strip()]
    have = {(r[1], r[2]) for r in rows}
    next_id = max(int(r[0]) for r in rows) + 1
    added = 0
    new = []
    for social in KNOWN + OTHER:
        for where in ("room", "channel"):
            for gender in ("female", "male"):
                new.append(("-", "#$#soundpack social | %s | %s | %s" % (where, gender, social)))
    new.append(("SocialSounds=0", "#$#soundpack social | room | female | cheer"))
    with open(path, "a", encoding="utf-8", newline="\n") as fh:
        for settings, line in new:
            if (settings, line) in have:
                continue
            fh.write("%d\t%s\t%s\n" % (next_id, settings, line))
            next_id += 1
            added += 1
    print("added %d social lines" % added)


if __name__ == "__main__":
    main()
