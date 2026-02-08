local Ini = require("ini")
local Path = require("pl.path")

ConfigTable = {}
ConfigTable.Settings = {}
ConfigTable.Settings.ScreenReader = "MushReader"
ConfigTable.Settings.Accents = 1
ConfigTable.Settings.VolumeType = 1
ConfigTable.Settings.SoundVolume = 20
ConfigTable.Settings.RoomVolume = 15
ConfigTable.Settings.CombatVolume = 15
ConfigTable.Settings.AlarmSounds = 1
ConfigTable.Settings.GlobalSounds = 1
ConfigTable.Settings.RoomSounds = 1
ConfigTable.Settings.CombatSounds = 1
ConfigTable.Settings.SocialSounds = 1
ConfigTable.Settings.Music = 1
ConfigTable.Settings.Numpad = 1
ConfigTable.Settings.CollectingMessages = 0
ConfigTable.Settings.SalvagingMessages = 0
ConfigTable.Settings.GrabbingMessages = 0
ConfigTable.Settings.HarvestingMessages = 0
ConfigTable.Settings.Roundtime = 1
ConfigTable.Settings.CommpipeHarvestFilter = 1
ConfigTable.Settings.SpeakSniperTarget = 1

function ToggleCommpipeHarvestFilter()
  if (ConfigTable.Settings.CommpipeHarvestFilter == 1) then
    ConfigTable.Settings.CommpipeHarvestFilter = 0
    Execute("tts_interrupt Commpipe harvest filter disabled.")
  elseif (ConfigTable.Settings.CommpipeHarvestFilter == 0) then
    ConfigTable.Settings.CommpipeHarvestFilter = 1
    Execute("tts_interrupt Commpipe harvest filter enabled.")
  end
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Switch.ogg")
  SaveConfig()
end

function ToggleSpeakSniperTarget()
  if (ConfigTable.Settings.SpeakSniperTarget == 1) then
    ConfigTable.Settings.SpeakSniperTarget = 0
    Execute("tts_interrupt Speak sniper target disabled.")
  elseif (ConfigTable.Settings.SpeakSniperTarget == 0) then
    ConfigTable.Settings.SpeakSniperTarget = 1
    Execute("tts_interrupt Speak sniper target enabled.")
  end
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Switch.ogg")
  SaveConfig()
end

function NumpadSwitch()
  if (ConfigTable.Settings.Numpad == 1) then
    ConfigTable.Settings.Numpad = 2
    Execute("tts_interrupt Numpad switched to navigation mode.")
  elseif (ConfigTable.Settings.Numpad == 2) then
    ConfigTable.Settings.Numpad = 1
    Execute("tts_interrupt Numpad switched to walk mode.")
  end
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Switch.ogg")
  NumpadInit()
  SaveConfig()
end

function ToggleVolumeType()
  if (ConfigTable.Settings.VolumeType == 1) then
    ConfigTable.Settings.VolumeType = 2
    Execute("tts_interrupt Volume control for room sounds.")
  elseif (ConfigTable.Settings.VolumeType == 2) then
    ConfigTable.Settings.VolumeType = 3
    Execute("tts_interrupt Volume control for combat sounds.")
  else
    ConfigTable.Settings.VolumeType = 1
    Execute("tts_interrupt Volume control for global sounds.")
  end
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Switch.ogg")
  SaveConfig();
end

function ToggleGlobalSounds()
  if (ConfigTable.Settings.GlobalSounds == 1) then
    ConfigTable.Settings.GlobalSounds = 0
    StopSound(CurrentGlobalSound)
    Execute("tts_interrupt Global sounds disabled.")
  elseif (ConfigTable.Settings.GlobalSounds == 0) then
    ConfigTable.Settings.GlobalSounds = 1
    Execute("tts_interrupt Global sounds enabled.")
  end
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Switch.ogg")
end

function ToggleRoomSounds()
  if (ConfigTable.Settings.RoomSounds == 1) then
    ConfigTable.Settings.RoomSounds = 0
    StopSound(CurrentRoomSound)
    Execute("tts_interrupt Room sounds disabled.")
  elseif (ConfigTable.Settings.RoomSounds == 0) then
    ConfigTable.Settings.RoomSounds = 1
    Execute("tts_interrupt Room sounds enabled.")
  end
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Switch.ogg")
end

function ToggleCombatSounds()
if (ConfigTable.Settings.CombatSounds == 1) then
ConfigTable.Settings.CombatSounds = 0
    StopSound(CurrentCombatSound)
    Execute("tts_interrupt Combat sounds disabled.")
  elseif (ConfigTable.Settings.CombatSounds == 0) then
    ConfigTable.Settings.CombatSounds = 1
    Execute("tts_interrupt Combat sounds enabled.")
  end
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Switch.ogg")
end

function ToggleAlarmSounds()
  if (ConfigTable.Settings.AlarmSounds == 1) then
    ConfigTable.Settings.AlarmSounds = 0
    Execute("tts_interrupt Alarm sounds disabled.")
  elseif (ConfigTable.Settings.AlarmSounds == 0) then
    ConfigTable.Settings.AlarmSounds = 1
    Execute("tts_interrupt Alarm sounds enabled.")
  end
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Switch.ogg")
end

function ToggleSocialSounds()
  if (ConfigTable.Settings.SocialSounds == 1) then
    ConfigTable.Settings.SocialSounds = 0
    Execute("tts_interrupt Social sounds disabled.")
  elseif (ConfigTable.Settings.SocialSounds == 0) then
    ConfigTable.Settings.SocialSounds = 1
    Execute("tts_interrupt Social sounds enabled.")
  end
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Switch.ogg")
end

function LoadConfig()
  if (Path.exists(Workspace.."Config.txt")) then
    ConfigTable = Ini.read("Config.txt")
    if ConfigTable then
      for name, section in pairs(ConfigTable) do
        for option_name, option_value in pairs(section) do
          config = tonumber(option_value)
          if config == nil then
            config = option_value
          end
          if ConfigTable[name] == nil then
            ConfigTable[name] = {}
          end
          ConfigTable[name][option_name] = config
        end
      end
    end
  end
  NumpadInit()
end

function SaveConfig()
  if (Path.exists(Workspace.."Config.txt")) then
    Ini.write("Config.txt", ConfigTable)
  else
    f = io.open(prometheus.core.bootstrap.Workspace.."Config.txt", "w")
    Ini.write("Config.txt", ConfigTable)
    f:close()
  end
end

function ReloadSoundpack()
  StopSound(CurrentGlobalSound)
  StopSound(CurrentRoomSound)
  StopSound(CurrentCombatSound)
  Note("Soundpack reloaded.")
  ReloadPlugin("ad8f25246eb08f268411d690")
end
