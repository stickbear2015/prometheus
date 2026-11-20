-- Soundpack messages from the game (#$# lines), registration and keep-alives.
-- Trigger functions for worlds/plugins/prometheus/system.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

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

-- ^\#\$\#soundpack social \| (channel|room) \| (female|male|neuter) \| (.+)$
function System_SoundpackSocialChannelRoomFemaleMale(name, line, wildcards)
  if (ConfigTable.Settings.SocialSounds == 1) then
    if (string.match(wildcards[3], "pyrianSay")) then
      if (string.match(wildcards[1], "room")) then
        CurrentGlobalSound = PlayGlobalSound("Socials/PyrianChitter"..math.random(1, 10)..".ogg")
      end
    elseif (string.match(wildcards[3], "belch")) then
      CurrentGlobalSound = PlayGlobalSound("Socials/Belch"..math.random(1, 3)..".ogg")
    elseif (string.match(wildcards[3], "burp")) then
      CurrentGlobalSound = PlayGlobalSound("Socials/Burp"..math.random(1, 5)..".ogg")
    elseif (string.match(wildcards[3], "cackle")) then
      CurrentGlobalSound = PlayGlobalSound("Socials/Cackle_" .. wildcards[2] .. ".ogg")
    elseif (string.match(wildcards[3], "cheer")) then
      CurrentGlobalSound = PlayGlobalSound(("Socials/Cheer_" .. wildcards[2])..math.random(1, 3)..".ogg")
    elseif (string.match(wildcards[3], "collapse")) then
      CurrentGlobalSound = PlayGlobalSound("General/Socials/Collapse"..math.random(1, 3)..".ogg")
    elseif (string.match(wildcards[3], "cough")) then
      CurrentGlobalSound = PlayGlobalSound("Socials/Cough_" .. wildcards[2] .. ".ogg")
    elseif (string.match(wildcards[3], "cry")) then
      CurrentGlobalSound = PlayGlobalSound("Socials/Cry"..math.random(1, 4)..".ogg")
    elseif (string.match(wildcards[3], "fart")) then
      CurrentGlobalSound = PlayGlobalSound("Socials/Fart"..math.random(1, 5)..".ogg")
    elseif (string.match(wildcards[3], "gag")) then
      CurrentGlobalSound = PlayGlobalSound("Socials/Gag"..math.random(1, 2)..".ogg")
    elseif (string.match(wildcards[2], "female") and string.match(wildcards[3], "giggle")) then
      CurrentGlobalSound = PlayGlobalSound("Socials/Giggle"..math.random(1, 7)..".ogg")
    elseif (string.match(wildcards[1], "room") and string.match(wildcards[3], "hmm")) then
      CurrentGlobalSound = PlayGlobalSound("Socials/Say.ogg")
    elseif (string.match(wildcards[3], "kick")) then
      if (string.match(wildcards[1], "room")) then
        CurrentCombatSound = PlayCombatSound(("Ground/Fight/" .. wildcards[2] .. "/")..math.random(1, 20)..".ogg")
      end
      CurrentGlobalSound = PlayGlobalSound("Socials/Kick"..math.random(1, 9)..".ogg")
    elseif (string.match(wildcards[3], "kiss")) then
      CurrentGlobalSound = PlayGlobalSound("Socials/Kiss"..math.random(1, 2)..".ogg")
    elseif (string.match(wildcards[3], "laugh")) then
      CurrentGlobalSound = PlayGlobalSound(("Socials/Laugh_" .. wildcards[2])..math.random(1, 2)..".ogg")
    elseif (string.match(wildcards[3], "lol")) then
      CurrentGlobalSound = PlayGlobalSound(("Socials/Lol_" .. wildcards[2])..math.random(1, 2)..".ogg")
    elseif (string.match(wildcards[3], "moan")) then
      CurrentGlobalSound = PlayGlobalSound(("Socials/Moan_" .. wildcards[2])..math.random(1, 2)..".ogg")
    elseif (string.match(wildcards[3], "punch")) then
      if (string.match(wildcards[1], "room")) then
        CurrentCombatSound = PlayCombatSound(("Ground/Fight/" .. wildcards[2] .. "/")..math.random(1, 20)..".ogg")
      end
      CurrentGlobalSound = PlayGlobalSound("Socials/Punch"..math.random(1, 10)..".ogg")
    elseif (string.match(wildcards[3], "rofl")) then
      CurrentGlobalSound = PlayGlobalSound(("Socials/Rofl_" .. wildcards[2])..math.random(1, 2)..".ogg")
    elseif (string.match(wildcards[3], "scream")) then
      CurrentGlobalSound = PlayGlobalSound("Socials/Scream_" .. wildcards[2] .. ".ogg")
    elseif (string.match(wildcards[3], "sigh")) then
      CurrentGlobalSound = PlayGlobalSound(("Socials/Sigh_" .. wildcards[2])..math.random(1, 2)..".ogg")
    elseif (string.match(wildcards[3], "slap")) then
      CurrentGlobalSound = PlayGlobalSound("Socials/Slap"..math.random(1, 5)..".ogg")
    elseif (string.match(wildcards[3], "snap")) then
      CurrentGlobalSound = PlayGlobalSound("Socials/Snap"..math.random(1, 3)..".ogg")
    elseif (string.match(wildcards[3], "tackle")) then
      CurrentGlobalSound = PlayGlobalSound("Socials/Tackle"..math.random(1, 5)..".ogg")
    elseif (string.match(wildcards[3], "whistle")) then
      CurrentGlobalSound = PlayGlobalSound("Socials/Whistle"..math.random(1, 6)..".ogg")
    elseif (string.match(wildcards[3], "yawn")) then
      CurrentGlobalSound = PlayGlobalSound("Socials/Yawn_" .. wildcards[2] .. ".ogg")
    else
      CurrentGlobalSound = PlayGlobalSound("Socials/" .. wildcards[3] .. ".ogg")
    end
    if (string.match(wildcards[1], "room")) then
      if (string.match(wildcards[3], "stand")) then
        CurrentGlobalSound = PlayGlobalSound("Socials/Stand.ogg")
      elseif (string.match(wildcards[3], "sit")) then
        CurrentGlobalSound = PlayGlobalSound("Socials/Sit.ogg")
      end
    end
  end
end
