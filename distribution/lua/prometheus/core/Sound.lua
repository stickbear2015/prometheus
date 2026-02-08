local Path = require("pl.path")

function PlayGlobalSound(file, pan)
  if (ConfigTable.Settings.GlobalSounds == 1) then
    pan = pan or 0
    if not Path.isabs(file) then
      file = SoundFolder..file
    end
    return Audio.play(file, 0, pan, ConfigTable.Settings.SoundVolume)
  end
end

function PlayRoomSound(file)
  if (ConfigTable.Settings.RoomSounds == 1) then
    if not Path.isabs(file) then
      file = SoundFolder.."Rooms/"..file
    end
    return Audio.play(file, 1, 0, ConfigTable.Settings.RoomVolume)
  end
end

function PlayCombatSound(file, pan)
  if (ConfigTable.Settings.CombatSounds == 1) then
    pan = pan or 0
    if not Path.isabs(file) then
      file = SoundFolder.."Combat/"..file
    end
    return Audio.play(file, 0, pan, ConfigTable.Settings.CombatVolume)
  end
end

function StopSound(id)
  if ((tonumber(id) ~= nil) and (Audio.isPlaying(id) == 1)) then
    return Audio.stop(id)
  end
end

-- To be improved
function SetVolume(CurrentVolume)
  if (ConfigTable.Settings.VolumeType == 1) then
    if (ConfigTable.Settings.GlobalSounds == 1) then
      if (ConfigTable.Settings.SoundVolume + CurrentVolume < 0 or ConfigTable.Settings.SoundVolume + CurrentVolume > 100) then
        if (ConfigTable.Settings.SoundVolume + CurrentVolume > 100) then
          CurrentGlobalSound = PlayGlobalSound("General/Misc/Error.ogg")
          Execute("tts_interrupt Global sound volume can't go higher.")
          return
        elseif (ConfigTable.Settings.SoundVolume + CurrentVolume < 1) then
          CurrentGlobalSound = PlayGlobalSound("General/Misc/Error.ogg")
          Execute("tts_interrupt Global sound volume can't go lower.")
          return
        end
      else
        ConfigTable.Settings.SoundVolume = ConfigTable.Settings.SoundVolume + CurrentVolume
        CurrentGlobalSound = PlayGlobalSound("General/Misc/Switch.ogg")
        Execute("tts_interrupt Global Sound Volume: "..tostring(ConfigTable.Settings.SoundVolume).." percent.")
        return Audio.setVol(ConfigTable.Settings.SoundVolume, CurrentGlobalSound)
      end
    elseif (ConfigTable.Settings.GlobalSounds == 0) then
      Execute("tts_interrupt Global sounds currently disabled.")
      return
    end
  elseif (ConfigTable.Settings.VolumeType == 2) then
    if (ConfigTable.Settings.RoomSounds == 1) then
      if (ConfigTable.Settings.RoomVolume + CurrentVolume < 0 or ConfigTable.Settings.RoomVolume + CurrentVolume > 100) then
        if (ConfigTable.Settings.RoomVolume + CurrentVolume > 100) then
          CurrentGlobalSound = PlayGlobalSound("General/Misc/Error.ogg")
          Execute("tts_interrupt Room sound volume can't go higher.")
          return
        elseif (ConfigTable.Settings.RoomVolume + CurrentVolume < 1) then
          CurrentGlobalSound = PlayGlobalSound("General/Misc/Error.ogg")
          Execute("tts_interrupt Room sound volume can't go lower.")
          return
        end
      else
        ConfigTable.Settings.RoomVolume = ConfigTable.Settings.RoomVolume + CurrentVolume
        CurrentGlobalSound = PlayGlobalSound("General/Misc/Switch.ogg")
        Execute("tts_interrupt Room Sound Volume: "..tostring(ConfigTable.Settings.RoomVolume).." percent.")
        return Audio.setVol(ConfigTable.Settings.RoomVolume, CurrentRoomSound)
      end
    else
      Execute("tts_interrupt Room sounds currently disabled.")
      return
    end
  elseif (ConfigTable.Settings.VolumeType == 3) then
    if (ConfigTable.Settings.CombatSounds == 1) then
      if (ConfigTable.Settings.CombatVolume + CurrentVolume < 0 or ConfigTable.Settings.CombatVolume + CurrentVolume > 100) then
        if (ConfigTable.Settings.CombatVolume + CurrentVolume > 100) then
          CurrentGlobalSound = PlayGlobalSound("General/Misc/Error.ogg")
          Execute("tts_interrupt Combat sound volume can't go higher.")
          return
        elseif (ConfigTable.Settings.CombatVolume + CurrentVolume < 1) then
          CurrentGlobalSound = PlayGlobalSound("General/Misc/Error.ogg")
          Execute("tts_interrupt Combat sound volume can't go lower.")
          return
        end
      else
        ConfigTable.Settings.CombatVolume = ConfigTable.Settings.CombatVolume + CurrentVolume
        CurrentGlobalSound = PlayGlobalSound("General/Misc/Switch.ogg")
        Execute("tts_interrupt Combat Sound Volume: "..tostring(ConfigTable.Settings.CombatVolume).." percent.")
        return Audio.setVol(ConfigTable.Settings.CombatVolume, CurrentCombatSound)
      end
    else
      Execute("tts_interrupt Combat sounds currently disabled.")
      return
    end
  end
end
