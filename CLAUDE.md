# Prometheus soundpack

MUSHclient soundpack for Prometheus: The Eternal Wars. Kendal's repo (`stickbear2015/prometheus`), inherited from another author (the plugin says "Krinnzenn"), so it's messy.

## Layout

- `prometheus/`: the packaged MUSHclient folder that players get (mushclient.exe, DLLs, sounds and scripts).
  - `worlds/EternalWars.mcl`: the world file.
  - `worlds/plugins/Prometheus.xml`: the main plugin. On the cleanup branch it holds the header, the aliases and the script block, and pulls in the triggers from `worlds/plugins/prometheus/<area>.xml` (system, comms, starship, combat, activities, devices, vehicles, socials, general, gags). Each trigger names a Lua function in `lua/prometheus/triggers/<area>.lua`, which gets `(name, line, wildcards)`. (On `dev` it's still one 8,781-line file with the Lua in the send boxes.) MUSHclient looks for a plugin's includes in its plugins folder, `worlds\plugins`.
  - `worlds/plugins/`: other plugins (channel_history, output_functions, universal_text_to_speech, LuaAudio and so on).
  - `lua/prometheus/`: the started modern modules: `main.lua`, `core/` (bootstrap, config, plugin, Sound), `sounds.lua` (`OnOOBmsg` for `#$#soundpack` lines), `help.lua`, `macros/`, `util.lua`.
  - `sounds/`: about 1,900 .ogg files (Combat, Footsteps, General, Music, Rooms, Socials, Starship, Vehicle).
- `original sounds/`: a temporary copy of the sounds from before they were trimmed (issue #36). To be removed once the edge cases are fixed.
- `changelog.md`: the player-facing changelog; the "development version" section lists unreleased changes with issue links.
- `prometheus.iss`: the installer. Note that it copies `prometheus\*` from the folder on disk, so local files (Config.txt, logs written while playing from the repo) go into it too.
- `tools/test-build/make-test-zip.ps1`: makes a tester zip from the last commit (never from disk), named `Prometheus-<label>-test-<yyyyMMdd>-<commit>.zip`, with the installer's layout (`mushclient\` plus `changelog.html`) and `TESTING-README.txt`. It stops if the pack has uncommitted changes. Run it from PowerShell: `.	ools	est-build\make-test-zip.ps1` (optional `-Label word`).

## Sound functions

`PlayGlobalSound(file, pan)`, `PlayRoomSound(file)` and `PlayCombatSound(file, pan)` in `lua/prometheus/core/Sound.lua`. Paths are relative to `sounds/` (Room and Combat add their subfolder). Each respects its on/off setting and volume in `ConfigTable.Settings`.

## Working rules

- Branches: `master` is released, and `dev` is development. Feature work happens on a branch, then a pull request into `dev`. Delete merged branches.
- Commit, and push straight after every commit (Kendal's own repo).
- Every change that players notice gets a line in `changelog.md` under the development version, with its issue link.
- Players' existing settings must keep working after an update.
- Testing: LuaJIT (Lua 5.1 compatible) is installed at `C:\Users\spopp\AppData\Local\Programs\LuaJIT\bin\luajit.exe` (installed 2026-11-20 for the cleanup's test tool).

## Cleanup branch rule (Kendal, 2026-11-20)

**Nothing from the cleanup goes into `dev` (no merge, no pull request merge, no commits on `dev`) unless Kendal explicitly says so.** All cleanup work stays on `cleanup/tidy-pack`. Opening a draft pull request for review is fine only if Kendal asks for one.

## Cleanup decisions

- **2026-11-20: one Prometheus plugin, split into several files.** `Prometheus.xml` pulls in area files with `<include>` (comms, starship, combat, socials and so on), each with its Lua beside it. It stays one plugin, so the first matching trigger still stops the rest, and settings and sounds stay shared. Not separate plugins, which would each see every line (double sounds) and need their settings passed between them. Decided by Kendal after discussing it with another pack developer.
- **Global plugins (Kendal wants this, to stop players breaking the pack by removing plugins):** the pack's plugins go in MUSHclient's global plugin list (`PluginList` in `mushclient_prefs.sqlite`, currently empty) instead of the world file. The upgrade must remove them from players' world files at the same time (or they load twice), add to the preferences file rather than replace it (it holds players' own preferences), and keep LuaAudio loading before Prometheus. Details to settle before doing it.
- **2026-11-20: the cleanup fixes existing problems; it doesn't add things that don't exist** (Kendal). For example, no neuter social sounds: the game has no neuter gender, so the missing neuter files aren't a bug and stay as they are.
- Where things are stored: the world file (`.mcl`) holds world settings and its plugin list; `worlds/plugins/state/*-state.xml` holds each plugin's saved variables per world (git-ignored, player-specific); `mushclient_prefs.sqlite` holds global MUSHclient preferences; `Config.txt` holds the pack's own settings (volumes, sound switches, message filters).

## Current work

- **Cleanup** (issue #44, branch `cleanup/tidy-pack`, started 2026-11-20; never merge into `dev` without Kendal's say-so). Kendal is guiding.
  - Done: the test tool (`tools/trigger-test`: made-up and real-log baselines, `check_sounds.py`, `check_patterns.py`); step 2 part 1, splitting `Prometheus.xml` into area files with Lua functions and wildcards passed as values (fixes the quote-mark crashes); `spdebug` command; small bug fixes; the Commpipe nesting fix; and the five big if/elseif chains turned into lists using the helpers in `lua/prometheus/triggers/common.lua` (SOCIAL_SOUNDS, COMPUTER_ANNOUNCEMENTS, CHANNEL_SOUNDS and friends in comms.lua, BUTTON_SOUNDS, VEHICLE_SCREEN_SOUNDS, COMPUTER_REPORTS). Every step checked: no buffer command lost.
  - Changelog: Kendal writes it herself at the end (Markdown, then regenerates the HTML). Keep a full list of player-facing changes ready for her (see issue #44 comments and the commit log).
  - **Everything in the cleanup stays in issue #44** (Kendal, 2026-11-20): no separate issues for the leftovers.
  - Next: Kendal to choose. Options: global plugins (see decisions); splitting the large "general" area; the history_add helper tidy-up. The other ~700 trigger functions are already 3 lines or fewer.
  - Still silent, no recordings exist: hatch-cracking odd noise, vehicle beginning to explode, host food and drink, tradesman certificate, event mode and events added, equipment damaged, self-destruct at sixty, no debris, radio microphone on and off, hatch light flashing once and twice.
- **Issue #26** (cheering over the PA or IC comms plays the kiss sound): a game-side bug. The game sends `cheekkiss` instead of cheer. Reported to the game's staff on 2026-11-20. No pack change unless the game's fix needs one.
- Testing in game: build a tester zip with `tools/test-build/make-test-zip.ps1`. Real game logs for testing go in `temp-logs/` (git-ignored).
