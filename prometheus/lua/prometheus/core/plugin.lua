local Path = require("pl.path")

function OnPluginConnect()
  LoadConfig()
  if (ConfigTable.Settings.Music == 1) then
    CurrentGlobalSound = PlayGlobalSound("Music/"..math.random(1, 63)..".ogg")
  end
  Note("Soundpack Version "..GetVariable("version")..".")
  SetOption("send_keep_alives", 1)
end

function OnPluginDisconnect()
  StopSound(CurrentGlobalSound)
  StopSound(CurrentRoomSound)
  StopSound(CurrentCombatSound)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Disconnected.ogg")
  SaveConfig()
end

function OnPluginInstall()
  if Path.exists("Config.txt") then
    LoadConfig()
  else
    utils.msgbox("The Mush soundpack version "..GetVariable("version").." for Prometheus is now ready. Thanks for using!", "Congratulations", "ok", "!", 1)
    SaveConfig()
  end
  -- Every time the soundpack starts (or reloads), check that none of its files were changed
  -- outside it, and whether there's an update (issue #14). Quiet unless there's something to do.
  DoAfterSpecial(3, "Updater_Check(true)", sendto.script)
end

function OnPluginClose() SaveConfig() end
