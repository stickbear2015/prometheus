-- Soundpack messages from the game (#$# lines), registration and keep-alives.
-- Trigger functions for worlds/plugins/prometheus/system.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- Debug display of the hidden soundpack messages the game sends (#$#soundpack ...).
-- Switched on and off with the spdebug command. Off at every start, never saved.
SoundpackDebug = false

function ToggleSoundpackDebug()
  SoundpackDebug = not SoundpackDebug
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Switch.ogg")
  if SoundpackDebug then
    Execute("tts_interrupt Showing soundpack messages.")
  else
    Execute("tts_interrupt Hiding soundpack messages.")
  end
end

-- ^\#\$\#soundpack(.*)$  (runs before every other trigger, and lets them run too)
function System_ShowSoundpackMessage(name, line, wildcards)
  if SoundpackDebug then
    Note("[soundpack message] " .. line)
  end
end

-- ^\#\$\#mcp version\: 2\.1 to\: 2\.1$
function System_McpVersionTo(name, line, wildcards)
  Execute("#$#register_soundpack Mush Soundpack | "..GetVariable("version"))
end

-- ^\#\$\#register_soundpack (registered|old_version \| (.+))$
function System_RegisterSoundpackRegisteredOldVersion(name, line, wildcards)
  if (string.match(wildcards[1], "old_version")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Outdated.ogg")
    packUpdate()
  end
end

-- ^\#\$\#register_soundpack old_version$
function System_RegisterSoundpackOldVersion(name, line, wildcards)
  if (string.match("", "old_version")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Outdated.ogg")
    packUpdate()
  end
end

-- Social sounds, checked from top to bottom; the first entry whose word appears in the
-- social's name is played. (So "cheer" is found before "kiss", and "cheekkiss" plays the
-- kiss sound.) Each entry:
--   word      a word to look for in the social's name
--   sound     the sound file, without the number and .ogg
--   versions  how many numbered versions there are (one is picked at random);
--             leave it out when there's just one file
-- and optionally:
--   gendered     the character's gender goes on the end of the name (Cheer_female1.ogg)
--   fight        in the room, also play a random fight sound (Combat/Ground/Fight/<gender>/1-20)
--   female_only  only counts for female characters; otherwise keep looking
--   room_only    only counts in the room; otherwise keep looking
--   room_sound   counts everywhere, but only makes a sound in the room
-- A social with no entry plays Socials/<social name>.ogg, if that file exists.
SOCIAL_SOUNDS = {
  { word = "pyrianSay", sound = "Socials/PyrianChitter", versions = 10, room_sound = true },
  { word = "belch", sound = "Socials/Belch", versions = 3 },
  { word = "burp", sound = "Socials/Burp", versions = 5 },
  { word = "cackle", sound = "Socials/Cackle_", gendered = true },
  { word = "cheer", sound = "Socials/Cheer_", gendered = true, versions = 3 },
  { word = "collapse", sound = "General/Socials/Collapse", versions = 3 },
  { word = "cough", sound = "Socials/Cough_", gendered = true },
  { word = "cry", sound = "Socials/Cry", versions = 4 },
  { word = "fart", sound = "Socials/Fart", versions = 5 },
  { word = "gag", sound = "Socials/Gag", versions = 2 },
  { word = "giggle", sound = "Socials/Giggle", versions = 7, female_only = true },
  { word = "hmm", sound = "Socials/Say", room_only = true },
  { word = "kick", sound = "Socials/Kick", versions = 9, fight = true },
  { word = "kiss", sound = "Socials/Kiss", versions = 2 },
  { word = "laugh", sound = "Socials/Laugh_", gendered = true, versions = 2 },
  { word = "lol", sound = "Socials/Lol_", gendered = true, versions = 2 },
  { word = "moan", sound = "Socials/Moan_", gendered = true, versions = 2 },
  { word = "punch", sound = "Socials/Punch", versions = 10, fight = true },
  { word = "rofl", sound = "Socials/Rofl_", gendered = true, versions = 2 },
  { word = "scream", sound = "Socials/Scream_", gendered = true },
  { word = "sigh", sound = "Socials/Sigh_", gendered = true, versions = 2 },
  { word = "slap", sound = "Socials/Slap", versions = 5 },
  { word = "snap", sound = "Socials/Snap", versions = 3 },
  { word = "tackle", sound = "Socials/Tackle", versions = 5 },
  { word = "whistle", sound = "Socials/Whistle", versions = 6 },
  { word = "yawn", sound = "Socials/Yawn_", gendered = true },
}

-- The first entry in SOCIAL_SOUNDS that fits this social, or nil.
local function find_social_sound(social, where, gender)
  for _, entry in ipairs(SOCIAL_SOUNDS) do
    if string.match(social, entry.word)
        and not (entry.female_only and not string.match(gender, "female"))
        and not (entry.room_only and not string.match(where, "room")) then
      return entry
    end
  end
  return nil
end

-- ^\#\$\#soundpack social \| (channel|room) \| (female|male|neuter) \| (.+)$
-- wildcards: 1 = where (channel or room), 2 = gender, 3 = the social's name
function System_SoundpackSocialChannelRoomFemaleMale(name, line, wildcards)
  if ConfigTable.Settings.SocialSounds ~= 1 then
    return
  end
  local where, gender, social = wildcards[1], wildcards[2], wildcards[3]
  local in_room = string.match(where, "room")
  local entry = find_social_sound(social, where, gender)

  if entry == nil then
    CurrentGlobalSound = PlayGlobalSound("Socials/" .. social .. ".ogg")
  elseif not entry.room_sound or in_room then
    if entry.fight and in_room then
      CurrentCombatSound = PlayCombatSound("Ground/Fight/" .. gender .. "/" .. math.random(1, 20) .. ".ogg")
    end
    local file = entry.sound
    if entry.gendered then
      file = file .. gender
    end
    if entry.versions then
      file = file .. math.random(1, entry.versions)
    end
    CurrentGlobalSound = PlayGlobalSound(file .. ".ogg")
  end

  -- Standing up and sitting down in the room also get a sound.
  if in_room then
    if string.match(social, "stand") then
      CurrentGlobalSound = PlayGlobalSound("Socials/Stand.ogg")
    elseif string.match(social, "sit") then
      CurrentGlobalSound = PlayGlobalSound("Socials/Sit.ogg")
    end
  end
end
