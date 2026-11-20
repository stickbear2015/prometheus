-- Hand-held devices and equipment.
-- Trigger functions for worlds/plugins/prometheus/devices.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- The screen of * hypernet browser with * touchscreen flashes briefly, indicating that *
function Devices_TheScreenOfHypernetBrowserWith(name, line, wildcards)
  Execute("history_add All=" .. wildcards[3])
  Execute("history_add HyperNetNotifications=" .. wildcards[3])
  CurrentGlobalSound = PlayGlobalSound("General/Devices/NewsFlash.ogg")
  if (string.match(wildcards[3], "new hypermail waiting for you")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/NewMail.ogg")
  elseif (string.match(wildcards[3], "There is a new message in the forums")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/NewForumPost.ogg")
  end
  Note("The screen of your hypernet browser with " .. wildcards[2] .. " touchscreen flashes briefly, informing you:")
  Note(wildcards[3])
end

-- You press a large button on * wormhole recall remote.
function Devices_YouPressALargeButtonOn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/ButtonPush.ogg")
end

-- * press*a button*.
function Devices_PressAButton(name, line, wildcards)
  if (string.match(wildcards[3], "to stop ongoing harvest") or string.match(wildcards[3], "on top of")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/ButtonPush.ogg")
  elseif (string.match(wildcards[3], "chair with")) then
    if (string.match(wildcards[3], "leaning it back")) then
      CurrentGlobalSound = PlayGlobalSound("General/Misc/Chair1.ogg")
    elseif (string.match(wildcards[3], "leaning it forward")) then
      CurrentGlobalSound = PlayGlobalSound("General/Misc/Chair2.ogg")
    elseif (string.match(wildcards[3], "ing it")) then
      CurrentGlobalSound = PlayGlobalSound("General/Misc/Chair3.ogg")
    end
  elseif (string.match(wildcards[3], "laser power supplier")) then
    CurrentCombatSound = PlayCombatSound("Ground/PowerSupplierButton.ogg")
  elseif (string.match(wildcards[3], "underwater scanner")) then
    CurrentGlobalSound = PlayGlobalSound("General/PearlDiving/Scanning.ogg")
  elseif (string.match(wildcards[3], "capacity weapon safe")) then
    if (string.match(wildcards[3], "open")) then
      CurrentGlobalSound = PlayGlobalSound("General/Misc/SafeOpen.ogg")
    elseif (string.match(wildcards[3], "close")) then
      CurrentGlobalSound = PlayGlobalSound("General/Misc/SafeClose.ogg")
    end
  elseif (string.match(wildcards[3], "on a nearby console and study the data displayed on its screen")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
  elseif (string.match(wildcards[3], "viewscreen")) then
    if (string.match(wildcards[3], "enabling")) then
      CurrentGlobalSound = PlayGlobalSound("General/Devices/Activate.ogg")
    elseif (string.match(wildcards[3], "disabling")) then
      CurrentGlobalSound = PlayGlobalSound("General/Devices/Deactivate.ogg")
    end
  elseif (string.match(wildcards[3], "water begins to spray")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/ButtonPush.ogg")
    StopSound(CurrentRoomSound)
    CurrentRoomSound = PlayRoomSound("Misc/Shower.ogg")
  elseif (string.match(wildcards[3], "causing the spray of water to stop")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/ButtonPush.ogg")
    StopSound(CurrentRoomSound)
    CurrentGlobalSound = PlayGlobalSound("General/Misc/ShowerEnd.ogg")
  elseif (string.match(wildcards[3], "pouring from a spout")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/ButtonPush.ogg")
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Pour.ogg")
  else
    CurrentGlobalSound = PlayGlobalSound("General/Devices/ButtonPush.ogg")
  end
end

-- * push*a button*.
function Devices_PushAButton(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/ButtonPush.ogg")
end

-- You connect to the * channel.
function Devices_YouConnectToTheChannel(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/Activate.ogg")
end

-- You disconnect from the * channel.
function Devices_YouDisconnectFromTheChannel(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/Deactivate.ogg")
end

-- AFK notifications *
function Devices_AfkNotifications(name, line, wildcards)
  if (string.match(wildcards[1], "enabled")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/Activate.ogg")
  elseif (string.match(wildcards[1], "disabled")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/Deactivate.ogg")
  end
end

-- * press*a few keys on a console, * the * alert.
function Devices_PressAFewKeysOnA(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
  if (string.match(wildcards[3], "enabling")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/Activate.ogg")
  elseif (string.match(wildcards[3], "disabling")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/Deactivate.ogg")
  end
end

-- * pass*in front of * and look*at the display.
function Devices_PassInFrontOfAndLook(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/HandheldScanner.ogg")
end

-- The scans indicate that there might be an artifact at *
function Devices_TheScansIndicateThatThereMight(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/HandheldScanner.ogg")
  Note("Artifact at " .. wildcards[1])
end

-- You press * button labeled *
function Devices_YouPressButtonLabeled(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/ButtonPush.ogg")
end

-- You pour some berries into*and start making*.
function Devices_YouPourSomeBerriesIntoAnd(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/JuiceMachine.ogg")
end

-- * tap*an icon on the console.
function Devices_TapAnIconOnTheConsole(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/ButtonPush.ogg")
end

-- You press a button.
function Devices_YouPressAButton(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/ButtonPush.ogg")
end

-- You press the 'RELOAD' button.
function Devices_YouPressTheReloadButton(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/ButtonPush.ogg")
end

-- This communication device is *
function Devices_ThisCommunicationDeviceIs(name, line, wildcards)
  if (string.match(wildcards[1], "now connected")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/Activate.ogg")
  elseif (string.match(wildcards[1], "no longer trackable")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/Deactivate.ogg")
  end
end

-- Scans of * unfiltered.
function Devices_ScansOfUnfiltered(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/Activate.ogg")
end

-- Scans of * filtered.
function Devices_ScansOfFiltered(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/Deactivate.ogg")
end

-- * tap*a button, *.
function Devices_TapAButton(name, line, wildcards)
  if (string.match(wildcards[3], "bringing up the mined mineral status")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/ButtonPush.ogg")
  elseif (string.match(wildcards[3], "viewscreen")) then
    if (string.match(wildcards[3], "enabling")) then
      CurrentGlobalSound = PlayGlobalSound("General/Devices/Activate.ogg")
    elseif (string.match(wildcards[3], "disabling")) then
      CurrentGlobalSound = PlayGlobalSound("General/Devices/Deactivate.ogg")
    end
  end
end

-- A light next to the PA blinks off.
function Devices_ALightNextToThePa(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/Deactivate.ogg")
end

-- A light blinks on next to the PA.
function Devices_ALightBlinksOnNextTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/Activate.ogg")
end

-- * turn* UTF-Issue radio with * high-definition speaker *.
function Devices_TurnUtfIssueRadioWithHigh(name, line, wildcards)
  if (string.match(wildcards[4], "on")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/Activate.ogg")
  elseif (string.match(wildcards[4], "off")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/Deactivate.ogg")
  end
end

-- * Portable Military Computer with * touch screen flashes a message on its screen, telling you that a new report has been added to the network.
function Devices_PortableMilitaryComputerWithTouchScreen(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/NewMilitaryReport.ogg")
end

-- Condensing of multiple debris clouds *.
function Devices_CondensingOfMultipleDebrisClouds(name, line, wildcards)
  if (string.match(wildcards[1], "enabled")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/Activate.ogg")
  elseif (string.match(wildcards[1], "disabled")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/Deactivate.ogg")
  end
end

-- * activate* the jetpack of * spacesuit*
function Devices_ActivateTheJetpackOfSpacesuit(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/JetStart.ogg")
end

-- * jetpack of * spacesuit deactivates.
function Devices_JetpackOfSpacesuitDeactivates(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Devices/JetEnd.ogg")
end
