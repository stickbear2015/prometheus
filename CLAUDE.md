# Prometheus soundpack

MUSHclient soundpack for Prometheus: The Eternal Wars. Shane's repo (`stickbear2015/prometheus`), inherited from another author (the plugin says "Krinnzenn"), so it's messy.

## Layout

- `prometheus/`: the packaged MUSHclient folder that players get (mushclient.exe, DLLs, sounds and scripts).
  - `worlds/EternalWars.mcl`: the world file.
  - `worlds/plugins/Prometheus.xml`: the main plugin (about 8,800 lines, 795 triggers, 58 aliases). Most logic lives in trigger send boxes (`send_to="12"`, script).
  - `worlds/plugins/`: other plugins (channel_history, output_functions, universal_text_to_speech, LuaAudio and so on).
  - `lua/prometheus/`: the started modern modules: `main.lua`, `core/` (bootstrap, config, plugin, Sound), `sounds.lua` (`OnOOBmsg` for `#$#soundpack` lines), `help.lua`, `macros/`, `util.lua`.
  - `sounds/`: about 1,900 .ogg files (Combat, Footsteps, General, Music, Rooms, Socials, Starship, Vehicle).
- `original sounds/`: a temporary copy of the sounds from before they were trimmed (issue #36). To be removed once the edge cases are fixed.
- `changelog.md`: the player-facing changelog; the "development version" section lists unreleased changes with issue links.
- `prometheus.iss`: the installer.

## Sound functions

`PlayGlobalSound(file, pan)`, `PlayRoomSound(file)` and `PlayCombatSound(file, pan)` in `lua/prometheus/core/Sound.lua`. Paths are relative to `sounds/` (Room and Combat add their subfolder). Each respects its on/off setting and volume in `ConfigTable.Settings`.

## Working rules

- Branches: `master` is released, and `dev` is development. Feature work happens on a branch, then a pull request into `dev`. Delete merged branches.
- Commit, and push straight after every commit (Shane's own repo).
- Every change that players notice gets a line in `changelog.md` under the development version, with its issue link.
- Players' existing settings must keep working after an update.
- Testing: LuaJIT (Lua 5.1 compatible) is installed at `C:\Users\spopp\AppData\Local\Programs\LuaJIT\bin\luajit.exe` (installed 2026-11-20 for the cleanup's test tool).

## Current work

- **Cleanup** (issue #44, branch `cleanup/tidy-pack`, started 2026-11-20): build a test tool that compares old and new triggers on sample lines; move trigger logic from `Prometheus.xml` into Lua modules by area; pass wildcards as values instead of pasting `%1` into code; replace if/elseif chains with lookup tables; fix small bugs and list them. Shane is guiding.
