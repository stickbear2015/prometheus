# Trigger test tool

A safety net for the cleanup (issue #44). It feeds sample game lines through the pack's triggers and records what happens: every sound played, with its file, pan and volume, plus anything spoken, sent or shown, and any script errors. Run it before and after a change, then compare. If the cleanup changed nothing for players, the two recordings match.

It never touches MUSHclient or plays a sound. Python matches lines against triggers the way MUSHclient does, and LuaJIT (Lua 5.1 compatible) runs the pack's real Lua inside a pretend MUSHclient that records everything.

## Files

- `mushtrig.py`: reads a plugin's triggers and matches lines as MUSHclient does (wildcards, regular expressions, ignore case, sequence, keep evaluating, `%1` substitution).
- `harness.lua`: the pretend MUSHclient. It loads the plugin's includes, its script block and the `lua/prometheus` modules, then runs each test line's triggers.
- `gen_corpus.py`: builds the test lines from the triggers themselves, including the text each trigger's code checks for, and with each setting the code checks switched the other way.
- `run.py`: records a run, or compares two runs.
- `corpus.txt`: the test lines, made from the original plugin (1,516 lines). Keep it fixed during the cleanup, so old and new are tested on the same lines.
- `baseline.txt`: what the original plugin did with those lines. This is what the cleaned-up pack is compared against.
- `check_sounds.py`: checks that every sound the code can play exists, reading the code itself (so `"Beep" .. math.random(1, 5)` checks all five files). Run `python -I check_sounds.py ../../prometheus`.
- `check_patterns.py`: finds text checks that can never match: a capital letter looked for in a lowercased line, or a plain "-" in a Lua pattern (which isn't a hyphen there; write "%-"). Run `python -I check_patterns.py ../../prometheus`.
- `check_channel_steals.py`: runs every channel message in game logs through MUSHclient's trigger order and lists any other trigger that takes them from the channel trigger (losing the channel sound and buffers). Run `python -I check_channel_steals.py ../../prometheus/worlds/plugins/Prometheus.xml ../../temp-logs/<log>...`.
- `test_first_start.lua`: runs the pack's real install, connect, disconnect and close steps (OnPluginInstall and so on, with LoadConfig and SaveConfig) in an empty folder, as on a fresh install with no Config.txt. Run it twice in the same empty folder to check a second start reads the saved settings: `luajit test_first_start.lua <pack folder> <that empty folder>`, run from inside that folder. (The main test tool replaces LoadConfig and SaveConfig with stand-ins, so it can't catch problems inside them.)
- `real_corpus.py`: picks real example lines for each trigger from a game log (a few distinct lines per trigger, plus lines containing each text a trigger's code checks for). **Its output contains other players' names and chat, so it goes in `temp-logs/` (git-ignored) and is never committed**, along with its recordings.

## Use

From this folder:

```
python -I run.py record ../../prometheus/worlds/plugins/Prometheus.xml ../../prometheus corpus.txt new.txt
python -I run.py compare baseline.txt new.txt
```

With the real-log corpus (local only):

```
python -I real_corpus.py ../../prometheus/worlds/plugins/Prometheus.xml ../../temp-logs/real-corpus.txt ../../temp-logs/Prometheus.txt [more logs...]
python -I run.py record ../../prometheus/worlds/plugins/Prometheus.xml ../../prometheus ../../temp-logs/real-corpus.txt ../../temp-logs/real-baseline.txt
```

Make `real-corpus.txt` and `real-baseline.txt` once, from the original plugin, then compare later recordings against `real-baseline.txt`.

`compare` lists every test line whose results differ, and the count. Differences that are deliberate bug fixes must be listed in the pull request.

LuaJIT is expected at `C:\Users\spopp\AppData\Local\Programs\LuaJIT\bin\luajit.exe`; set the `LUAJIT` environment variable to use another path.

## How faithful it is

- Random numbers: `math.random` always returns its lowest value, and the range is recorded, so old and new are compared on the same choices.
- Settings start at their defaults from `core/config.lua` for every line, plus any setting the line flips.
- Unknown string escapes such as `\.` are treated as real Lua 5.1 does (the backslash is dropped). LuaJIT on its own would refuse them.
- Trigger order is MUSHclient's own: by sequence, then **alphabetically by match text** (case-sensitive). Confirmed from MUSHclient's source (`doc.cpp`, `CompareTrigger`: "identical sequence, sort into match order"). File order and trigger names play no part, so splitting the plugin into several files can't change which trigger wins. Triggers with the same sequence and the same match text have no defined order in MUSHclient; the tool uses file order for those. The plugin has three such pairs, which the cleanup should merge.
- `corpus.txt` is made up from the trigger patterns. The real-log corpus (`temp-logs/real-corpus.txt`, local only) adds real game text from players' logs (Shane's from 2022 onwards, and a second player's from 2026; 11 million lines in all). Run both before and after each change. Lines hidden by the pack (omitted from output) aren't in a log, so the made-up corpus still matters.

## Findings from the original plugin (2026-11-20)

- **From real game logs** (Shane's, plus a second player's added 2026-11-20: 11,061,598 lines, 1,526,758 unique; 2,469 real lines kept, covering 571 triggers, using MUSHclient's real trigger order): **99 of the 2,469 real lines (about 4%) crash their trigger's code before any sound plays.** Every one is the quote-mark problem: the game's text contains a quote mark, usually a ship name or channel message in quotes, and pasting it into the code breaks it. The worst affected are the general channel trigger, "* has fired * at *", "The computer announces", "The computer reports that", "You see several lights blink...", "* is here." and the door open and close triggers.

- 760 of 795 triggers fire on the made-up test lines. Most of the other 35 are caught first by a broader trigger that sorts earlier (for example `[Frequency *] *` is caught by the general `[channel]` trigger), so they never fire in the game either.
- **Fixed 2026-11-20:** trigger "The ship rocks slightly as planetary lasers impact the" had `math-random(...)` (a minus sign, so Lua tried to call `random()`, which doesn't exist). It errored after its first sound; now it plays all three.
- Trigger "^(.*) translator announces(.*?)\, "(.*)"$" puts the game's text straight into its code, which breaks on the test line. This is the quote-mark problem described in issue #44.
- **Fixed 2026-11-20 by the split:** the trigger matching "You hear the roar of * starship from outside." had a missing space between two attributes (`send_to="12"sequence="100"`). The split rewrote every trigger cleanly.
- **Fixed 2026-11-20:** a check for "Ppowering down due to lack of charge" (double P) could never match. The game says "Powering down" (35 times in the real logs), so that low-charge sound now plays.
- **Fixed 2026-11-20:** three pairs of triggers had identical patterns, so MUSHclient picked one at random. For "* lock*the door leading *." one played the lock sound and the other the unlock sound, and the same for unlock. Now lock plays Lock and unlock plays Unlock (8 real unlock lines changed). The two identical "You hear somebody trying to enter the ship." triggers are now one.
- The error in "The starship's computer prints * of the star research data." is from the made-up test text (it expects a number), not a pack bug.
