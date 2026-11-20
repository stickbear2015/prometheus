# Cleanup tools (issue #44)

One-off tools used to clean up the pack. They're kept so every step can be repeated and checked.

## split_plugin.py (step 2, part 1)

Splits the original 8,781-line `Prometheus.xml` into area files, without changing what any trigger does:

- Each trigger whose send box ran Lua now names a function (`script="Comms_DeniesYourRequest"`), and its code lives in `lua/prometheus/triggers/<area>.lua`, indented consistently.
- Game text is passed in as values (`wildcards[1]`, `line`) instead of being pasted into the code as `"%1"`. This fixes the triggers that crashed whenever the game's text contained a quote mark (99 of 2,469 real game lines tested).
- Unknown string escapes such as `\.` are written as plain `.`, which is what Lua 5.1 did with them anyway.
- The triggers are in `worlds/plugins/prometheus/<area>.xml`, and `Prometheus.xml` pulls them in with `<include>`. MUSHclient looks for a plugin's includes in its plugins folder (`worlds\plugins`), the same as the existing `constants.lua` include.
- Areas are chosen from the sounds each trigger plays: system, comms, starship, combat, activities, devices, vehicles, socials, general, and gags (hidden lines with no sound).
- Trigger order isn't affected: MUSHclient orders triggers by sequence, then by match text, never by file.

Run against the original plugin from `dev`:

```
git show dev:prometheus/worlds/plugins/Prometheus.xml > original-Prometheus.xml
python -I split_plugin.py original-Prometheus.xml ../../prometheus
```

Checked with `tools/trigger-test` on 2026-11-20: on the made-up lines, the only differences are the translator trigger now working (it used to crash on quote marks) and one made-up line full of backslashes that no real game line contains. On the real game lines, all 99 differences are lines that used to crash on quote marks and now play their sounds.

## split_general.py (step 3)

Splits the large "general" area (268 triggers) into areas by subject: refusals, game, household, teleporting, money, groups, health, items and games, leaving 56 in general. Each trigger is sorted by the first sound its function plays, moved with its function, and its function renamed to match (General_Wait... becomes Refusals_Wait...). Nothing inside any function changes. Checked with tools/trigger-test on 2026-11-20: no difference on any made-up or real game line.

## edit_triggers.py

Helpers for small hand-made edits to the trigger files: remove a trigger and its function, set an attribute such as the sequence, or replace text inside a function. Each edit finds triggers by their exact match text and stops if it doesn't find exactly one.
