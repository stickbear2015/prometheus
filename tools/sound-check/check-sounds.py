"""Checks changed sounds before they go in (Kendal, 2026-11-27), so a bulk sound change can't
quietly bring back old sounds again.

Usage, from the repo folder (needs ffmpeg, ffprobe and numpy):
    python tools/sound-check/check-sounds.py            the sounds changed but not committed yet
    python tools/sound-check/check-sounds.py <commit>   the sounds that commit changed
    python tools/sound-check/check-sounds.py <commit> <sound path> ...   only those sounds
It says how far it has got every few seconds.

For each sound it flags:
  - CHANGED SOUND: a changed sound isn't the same sound as the one it replaces (its audio isn't
    a trimmed or identical copy of the previous version). This catches an old version of a
    sound coming back, even trimmed.
  - CAME BACK: an added sound whose name was deleted or renamed earlier in the history.
  - FORMAT: the codec, sample rate or number of channels changed (sounds are never re-encoded).
It exits with 1 if anything was flagged, and changes nothing.
"""
import json
import os
import subprocess
import sys
import tempfile
import time

import numpy as np

SOUNDS = 'prometheus/sounds/'
EXT = ('.ogg', '.wav', '.mp3')
EDGE = 2048      # samples at each end allowed to differ (cuts land on whole packets)
PROBE = 4096


def git(*args, data=None):
    r = subprocess.run(['git', *args], capture_output=True, input=data)
    return r.stdout


def blob(rev, path):
    """A file's real bytes at a revision (Git LFS pointers are turned into the file)."""
    raw = git('show', f'{rev}:{path}')
    if raw.startswith(b'version https://git-lfs'):
        raw = git('lfs', 'smudge', data=raw)
    return raw


def info(p):
    j = json.loads(subprocess.run(['ffprobe', '-v', 'error', '-show_entries', 'stream=codec_name,sample_rate,channels', '-of', 'json', p], capture_output=True).stdout or b'{}')
    s = (j.get('streams') or [{}])[0]
    return s.get('codec_name'), s.get('sample_rate'), s.get('channels')


def pcm(p, ch):
    raw = subprocess.run(['ffmpeg', '-v', 'error', '-i', p, '-f', 's16le', '-acodec', 'pcm_s16le', '-'], capture_output=True).stdout
    return np.frombuffer(raw, dtype=np.int16).reshape(-1, max(1, ch))


def same_sound(old, new):
    """True when one's audio is the other's, or a trimmed piece of it (ends may differ by a
    packet): a trim, or putting back the untrimmed original."""
    return piece_of(old, new) or piece_of(new, old)


def piece_of(old, new):
    """True when new's audio is old's, or a trimmed piece of it."""
    if len(new) <= 2 * EDGE + PROBE:
        return len(new) <= len(old) + EDGE and len(old) <= 2 * EDGE + PROBE * 4
    probe = new[EDGE:EDGE + PROBE]
    for off in range(0, len(old) - len(new) + EDGE + 1):
        seg = old[off + EDGE:off + EDGE + PROBE]
        if len(seg) < PROBE:
            return False
        if np.array_equal(seg, probe):
            return np.array_equal(new[EDGE:len(new) - EDGE], old[off + EDGE:off + len(new) - EDGE])
    return False


def main():
    commit = sys.argv[1] if len(sys.argv) > 1 else None
    only = sys.argv[2:]
    if commit:
        before, after = f'{commit}^', commit
        lines = git('diff', '--name-status', '--no-renames', before, after, '--', *(only or [SOUNDS])).decode().splitlines()
    else:
        before, after = 'HEAD', None
        lines = git('diff', '--name-status', '--no-renames', 'HEAD', '--', SOUNDS).decode().splitlines()
    problems = []
    checked = 0
    total = len(lines)
    print(f'Checking {total} changed sounds.', flush=True)
    last = time.monotonic()
    with tempfile.TemporaryDirectory() as t:
        for n, line in enumerate(lines, 1):
            if time.monotonic() - last >= 3:
                last = time.monotonic()
                print(f'{n} of {total} sounds checked, {len(problems)} flagged so far.', flush=True)
            status, path = line.split('\t', 1)
            if not path.lower().endswith(EXT) or status == 'D':
                continue
            checked += 1
            new_bytes = blob(after, path) if after else open(path, 'rb').read()
            np_ = os.path.join(t, 'new' + os.path.splitext(path)[1])
            open(np_, 'wb').write(new_bytes)
            if status == 'A':
                gone = git('log', '--format=%h %ad %s', '--date=short', '--diff-filter=D', '-1', before, '--', path).decode().strip()
                if gone:
                    problems.append(f'CAME BACK: {path} was deleted or renamed in {gone}')
                continue
            op = os.path.join(t, 'old' + os.path.splitext(path)[1])
            open(op, 'wb').write(blob(before, path))
            fo, fn = info(op), info(np_)
            if fo != fn:
                problems.append(f'FORMAT: {path} was {fo}, now {fn}')
                continue
            if not same_sound(pcm(op, int(fo[2] or 1)), pcm(np_, int(fn[2] or 1))):
                problems.append(f"CHANGED SOUND: {path} isn't the same sound as before (not a trim of it). If that's meant, say so in the commit.")
    for p in problems:
        print(p)
    print(f'{checked} sounds checked, {len(problems)} flagged.')
    sys.exit(1 if problems else 0)


if __name__ == '__main__':
    main()
