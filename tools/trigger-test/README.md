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

## Use

From this folder:

```
python -I run.py record ../../prometheus/worlds/plugins/Prometheus.xml ../../prometheus corpus.txt new.txt
python -I run.py compare baseline.txt new.txt
```

`compare` lists every test line whose results differ, and the count. Differences that are deliberate bug fixes must be listed in the pull request.

LuaJIT is expected at `C:\Users\spopp\AppData\Local\Programs\LuaJIT\bin\luajit.exe`; set the `LUAJIT` environment variable to use another path.

## How faithful it is

- Random numbers: `math.random` always returns its lowest value, and the range is recorded, so old and new are compared on the same choices.
- Settings start at their defaults from `core/config.lua` for every line, plus any setting the line flips.
- Unknown string escapes such as `\.` are treated as real Lua 5.1 does (the backslash is dropped). LuaJIT on its own would refuse them.
- Trigger order: by sequence, then file order. **To check**: whether MUSHclient orders triggers with the same sequence differently. It doesn't affect old-versus-new comparisons as long as both use the same rule, but it does affect which triggers can never fire.
- Test lines are made up from the trigger patterns, so they're not real game text. Real game logs would make a better corpus later.

## Findings from the original plugin (2026-11-20)

- 758 of 795 triggers fire on the test lines. Most of the other 37 are caught first by an earlier, broader trigger (for example `[Frequency *] *` is caught by the general `[channel]` trigger). If MUSHclient orders them the same way, they never fire in the game either.
- Trigger "The ship rocks slightly as planetary lasers impact the" calls `random()`, which doesn't exist, so it errors after playing its first sound (should be `math.random`).
- Trigger "^(.*) translator announces(.*?)\, "(.*)"$" puts the game's text straight into its code, which breaks on the test line. This is the quote-mark problem described in issue #44.
- The trigger matching "You hear the roar of * starship from outside." has a missing space between two attributes (`send_to="12"sequence="100"`). MUSHclient tolerates it.
- A check for "Ppowering down due to lack of charge" (double P) can never match.
- The error in "The starship's computer prints * of the star research data." is from the made-up test text (it expects a number), not a pack bug.
