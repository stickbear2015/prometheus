# Prometheus soundpack

MUSHclient soundpack for Prometheus: The Eternal Wars. Kendal's repo (`stickbear2015/prometheus`), inherited from another author (the plugin says "Krinnzenn"), so it's messy.

## Layout

- `prometheus/`: the packaged MUSHclient folder that players get (mushclient.exe, DLLs, sounds and scripts).
  - `worlds/EternalWars.mcl`: the world file.
  - `worlds/plugins/Prometheus.xml`: the main plugin. It holds the header, the aliases and the script block, and pulls in the triggers from `worlds/plugins/prometheus/<area>.xml` (system, comms, starship, combat, activities, devices, vehicles, socials, refusals, game, household, teleporting, money, groups, health, items, games, general, gags). Each trigger names a Lua function in `lua/prometheus/triggers/<area>.lua`, which gets `(name, line, wildcards)`. (On `dev` it's still one 8,781-line file with the Lua in the send boxes.) MUSHclient looks for a plugin's includes in its plugins folder, `worlds\plugins`.
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
- **Never edit `changelog.md` or `changelog.html`.** They're Kendal's to write (Kendal, 2026-11-20). Instead, write the player-facing changes (with issue links) to a notes file in `C:\code\git-src\text-files` for her, and tell her it's there. Committing and pushing her own changelog edits is fine.
- Players' existing settings must keep working after an update.
- **Every message that goes into a buffer must also go into the All buffer** (Kendal, 2026-11-20). Use `AddToHistory(buffer, text, all_text)` from `lua/prometheus/triggers/common.lua`, which sends All first, then the other buffer. Checked 2026-11-20: every buffer message in both test recordings has its All entry.
- Testing: LuaJIT (Lua 5.1 compatible) is installed at `C:\Users\spopp\AppData\Local\Programs\LuaJIT\bin\luajit.exe` (installed 2026-11-20 for the cleanup's test tool).

## Cleanup decisions

- **2026-11-20: one Prometheus plugin, split into several files.** `Prometheus.xml` pulls in area files with `<include>` (comms, starship, combat, socials and so on), each with its Lua beside it. It stays one plugin, so the first matching trigger still stops the rest, and settings and sounds stay shared. Not separate plugins, which would each see every line (double sounds) and need their settings passed between them. Decided by Kendal after discussing it with another pack developer.
- **Global plugins: dropped** (Kendal, 2026-11-20). The pack's plugins stay loaded by the world file, as before.
- **2026-11-20: the cleanup fixes existing problems; it doesn't add things that don't exist** (Kendal). For example, no neuter social sounds: the game has no neuter gender, so the missing neuter files aren't a bug and stay as they are.
- Where things are stored: the world file (`.mcl`) holds world settings and its plugin list; `worlds/plugins/state/*-state.xml` holds each plugin's saved variables per world (git-ignored, player-specific); `mushclient_prefs.sqlite` holds global MUSHclient preferences; `Config.txt` holds the pack's own settings (volumes, sound switches, message filters).

## Current work

- **Cleanup (#44) and sound lockdown (#45): done and merged into `dev`** (pull request #46, merge commit b7996fa, 2026-11-21). The branch `cleanup/tidy-pack` and its backup are deleted. Both issues stay open on purpose: the merge commit says "Closes #44" and "Closes #45", so GitHub closes them automatically when `dev` is merged into `master` (the repo's default branch; GitHub only closes issues from commits on it). **When releasing `dev` into `master`, use a normal merge so that commit comes along**, or put "Closes #44" and "Closes #45" in the release pull request.
  - #44 was the cleanup: the test tool (`tools/trigger-test`), the plugin split into area files with Lua functions and wildcards passed as values (fixed the quote-mark crashes), the five big chains turned into lists (helpers in `lua/prometheus/triggers/common.lua`), the general area split by subject, `AddToHistory`, `spdebug`, and the bugs it turned up. Every step checked with the test tool: no buffer command lost.
  - #45 was the lockdown: players' text and socials mustn't set off game sounds. Clothing sounds only for real clothing changes; chat channels and speech checked before game-event triggers (sequence 50); no "* is dead!" room trigger (real deaths come over [Death]); bare weapon emotes ("fires a rifle!", "takes aim at you with a sniper!") silent via `is_bare_gun` in combat.lua; emoted falls silent (real falls are creatures named with "A"/"An"); bodily-noise socials (belch, burp, cough, fart, gag, sneeze, vomit, yawn) only sound in the room, while every other social plays on channels as it always did. Known limit: a room emote that copies game text word for word can't be told apart.
  - Decisions kept from that work: Camera, Movement and other game feeds keep playing their event sounds (Kendal). Two space combat lines that never had sounds ("X-Loritan ... fires a large energy beam towards <ship>." and "The starship shakes violently as it is impacted by a large beam of energy.") stay silent (Kendal, 2026-11-21).
- **Issues:** keep each issue up to date as we go: after each change, post a short comment on the right issue with the commit and what it does, without being asked (Kendal, 2026-11-20). Keep separate concerns in separate issues, with as little cross-linking as possible.
  - Still silent, no recordings exist: hatch-cracking odd noise, vehicle beginning to explode, host food and drink, tradesman certificate, event mode and events added, equipment damaged, self-destruct at sixty, no debris, radio microphone on and off, hatch light flashing once and twice.
- **Issue #26** (cheering over the PA or IC comms plays the kiss sound): a game-side bug. The game sends `cheekkiss` instead of cheer. Reported to the game's staff on 2026-11-20. No pack change unless the game's fix needs one.
- Testing in game: build a tester zip with `tools/test-build/make-test-zip.ps1`. Real game logs for testing go in `temp-logs/` (git-ignored).
