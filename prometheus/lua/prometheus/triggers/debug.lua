-- Debug reports for the spdebug command (issue #49).
-- While spdebug is on, the pack says what it does with each line from the game:
--   [debug] trigger Combat_Fire: <the line>       which trigger function caught it
--   [debug] sound: Combat/Ground/Lasers/Laser.ogg  each sound, and whether the file is
--                                                  missing or that kind of sound is off
--   [debug] buffer: Conversations                  each history buffer it went into
--   [debug] no trigger                             nothing in the pack caught it
-- Since issue #49 was reopened (Kendal, 2026-11-25), also:
--   [debug] game: #$#soundpack ...                 each soundpack line the game sends, with
--                                                  "(not handled)" when the pack doesn't know it
--   [debug] stop: Rooms/Vehicle/Mining.ogg         each sound stopped while it was playing
--   ... (volume 50)                                each sound's volume
--   [debug] timer: <what>                          each delayed sound or action, when it fires
--   [debug] trigger X: <line> (hidden)             the trigger keeps the line out of the output
-- and "spdebug now" says what room ambiance is playing, and which game line started it.
-- Nothing in the triggers changes. This file wraps the trigger functions, the sound
-- functions and Execute once, at startup, so they report in only while spdebug is on.
-- It must be required after all the other trigger files.

local Path = require("pl.path")

local function report(text)
  if SoundpackDebug then
    Note("[debug] " .. text)
  end
end

-- Which file each playing sound is, so stops can name it; and the room ambiance now playing,
-- with the game line that started it, for "spdebug now".
local playing = {}
local room = nil
local last_game_line = nil

-- Whether the triggers calling a function hide their line from the output. Unnamed triggers
-- reach their function without a name, so this is worked out once from the trigger list:
-- a function counts as hiding when every trigger that calls it hides its line.
local hiding = nil
local function hides(function_name)
  if not hiding then
    hiding = {}
    local ok, list = pcall(GetTriggerList)
    for _, t in ipairs(ok and list or {}) do
      local f = GetTriggerInfo(t, 4)
      if f and f ~= "" then
        local omit = GetTriggerInfo(t, 6) == true
        if hiding[f] == nil then
          hiding[f] = omit
        else
          hiding[f] = hiding[f] and omit
        end
      end
    end
  end
  return hiding[function_name] == true
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
    if SoundpackDebug then
      report("trigger " .. name .. ": " .. tostring(line) .. (hides(name) and " (hidden)" or ""))
    end
    return f(trigger_name, line, ...)
  end
end

-- Sounds: which file, and why it might be silent.
local function wrap_sound(function_name, setting, kind, subfolder, volume)
  local f = _G[function_name]
  _G[function_name] = function(file, ...)
    local shown = file
    local full = file
    if type(file) == "string" and not Path.isabs(file) then
      shown = subfolder .. file
      full = SoundFolder .. shown
    end
    -- The sound player's numbers for sounds can be negative, and it may give none for a sound
    -- that plays once, so any number counts as a sound to track.
    local id = f(file, ...)
    if type(id) == "number" then
      playing[id] = shown
      if function_name == "PlayRoomSound" then
        room = { id = id, file = shown, line = last_game_line, at = os.date("%I:%M:%S %p") }
      end
    end
    if SoundpackDebug then
      local why = ""
      if ConfigTable.Settings[setting] ~= 1 then
        why = " (" .. kind .. " sounds are off)"
      elseif not Path.isfile(full) then
        why = " (file missing)"
      else
        why = " (volume " .. tostring(ConfigTable.Settings[volume]) .. ")"
      end
      report("sound: " .. tostring(shown) .. why)
    end
    return id
  end
end
wrap_sound("PlayGlobalSound", "GlobalSounds", "global", "", "SoundVolume")
wrap_sound("PlayRoomSound", "RoomSounds", "room", "Rooms/", "RoomVolume")
wrap_sound("PlayCombatSound", "CombatSounds", "combat", "Combat/", "CombatVolume")

-- Stops: only a sound that was still playing.
local stop_sound = StopSound
function StopSound(id, ...)
  if SoundpackDebug and tonumber(id) and Audio.isPlaying(id) == 1 then
    report("stop: " .. (playing[id] or ("sound " .. tostring(id))))
  end
  if id ~= nil then
    playing[id] = nil
  end
  return stop_sound(id, ...)
end

-- The game's soundpack lines. The lines the pack knows are read from sounds.lua itself (each
-- `line == "..."`), plus its one pattern (skill improvements), so "(not handled)" stays right
-- when lines are added there.
local known = {}
do
  local path = package.searchpath and package.searchpath("prometheus.sounds", package.path)
  local f = path and io.open(path, "rb")
  if f then
    for text in string.gmatch(f:read("*a"), 'line == "([^"]*)"') do
      known[text] = true
    end
    f:close()
  end
end
local on_oob = OnOOBmsg
function OnOOBmsg(name, line, ...)
  if SoundpackDebug then
    local handled = known[line] or (string.match(line, "skills") and string.match(line, "improve"))
    report("game: " .. tostring(line) .. (handled and "" or " (not handled)"))
  end
  -- Only sounds started while this line is handled count as started by it.
  last_game_line = line
  local ok, err = pcall(on_oob, name, line, ...)
  last_game_line = nil
  if not ok then error(err, 0) end
end

-- Delayed actions: said when they fire.
local do_after_special = DoAfterSpecial
function DoAfterSpecial(seconds, what, send_to, ...)
  if send_to == sendto.script and type(what) == "string" then
    what = "if SoundpackDebug then Note(" .. string.format("%q", "[debug] timer: " .. what) .. ") end " .. what
  end
  return do_after_special(seconds, what, send_to, ...)
end

-- spdebug switches debug reports on and off; "spdebug now" says what room ambiance is playing.
function SoundpackDebug_Alias(name, line, wildcards)
  if string.lower(wildcards[1] or "") ~= "now" then
    return ToggleSoundpackDebug()
  end
  if room and Audio.isPlaying(room.id) == 1 then
    Note("Room ambiance: " .. room.file .. ", since " .. room.at .. ", started by: " .. tostring(room.line or "a trigger, not a game soundpack line"))
  else
    Note("No room ambiance is playing.")
  end
end

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
  -- The game's soundpack lines are reported as "game:" (their trigger keeps evaluating).
  if string.sub(line, 1, 3) == "#$#" then return end
  report("no trigger")
end
