-- Debug reports for the spdebug command (issue #49).
-- While spdebug is on, the pack says what it does with each line from the game:
--   [debug] trigger Combat_Fire: <the line>       which trigger function caught it
--   [debug] sound: Combat/Ground/Lasers/Laser.ogg  each sound, and whether the file is
--                                                  missing or that kind of sound is off
--   [debug] buffer: Conversations                  each history buffer it went into
--   [debug] no trigger                             nothing in the pack caught it
-- Nothing in the triggers changes. This file wraps the trigger functions, the sound
-- functions and Execute once, at startup, so they report in only while spdebug is on.
-- It must be required after all the other trigger files.

local Path = require("pl.path")

local function report(text)
  if SoundpackDebug then
    Note("[debug] " .. text)
  end
end

-- Trigger functions are named after their area file, such as Combat_Fire in combat.lua.
local AREAS = {
  "System", "Comms", "Starship", "Combat", "Activities", "Devices", "Vehicles",
  "Socials", "General", "Games", "Items", "Health", "Groups", "Money", "Teleporting",
  "Household", "Game", "Refusals", "Gags",
}
local is_area = {}
for _, a in ipairs(AREAS) do
  is_area[a] = true
end

-- These report in their own way, so they aren't wrapped.
local NOT_WRAPPED = {
  System_ShowSoundpackMessage = true,  -- shows the game's soundpack message itself
  System_DebugNoTrigger = true,        -- says "no trigger"
}

local names = {}
for name, f in pairs(_G) do
  local area = type(f) == "function" and string.match(name, "^(%u%a*)_%w")
  if area and is_area[area] and not NOT_WRAPPED[name] then
    table.insert(names, name)
  end
end
for _, name in ipairs(names) do
  local f = _G[name]
  -- The line goes in the note too, since many lines are hidden by their trigger and
  -- a tester would otherwise have nothing to copy into a report.
  _G[name] = function(trigger_name, line, ...)
    report("trigger " .. name .. ": " .. tostring(line))
    return f(trigger_name, line, ...)
  end
end

-- Sounds: which file, and why it might be silent.
local function wrap_sound(function_name, setting, kind, subfolder)
  local f = _G[function_name]
  _G[function_name] = function(file, ...)
    if SoundpackDebug then
      local shown = file
      local full = file
      if not Path.isabs(file) then
        shown = subfolder .. file
        full = SoundFolder .. shown
      end
      local why = ""
      if ConfigTable.Settings[setting] ~= 1 then
        why = " (" .. kind .. " sounds are off)"
      elseif not Path.isfile(full) then
        why = " (file missing)"
      end
      report("sound: " .. shown .. why)
    end
    return f(file, ...)
  end
end
wrap_sound("PlayGlobalSound", "GlobalSounds", "global", "")
wrap_sound("PlayRoomSound", "RoomSounds", "room", "Rooms/")
wrap_sound("PlayCombatSound", "CombatSounds", "combat", "Combat/")

-- Buffers: every history_add goes through Execute.
local execute = Execute
function Execute(command, ...)
  if SoundpackDebug then
    local buffer = string.match(command, "^history_add ([^=]+)=")
    if buffer then
      report("buffer: " .. buffer)
    end
  end
  return execute(command, ...)
end

-- The "DebugNoTrigger" trigger in system.xml is checked after every other trigger and
-- is only switched on while spdebug is on, so it fires only for lines nothing caught.
function System_DebugNoTrigger(name, line, wildcards)
  report("no trigger")
end
