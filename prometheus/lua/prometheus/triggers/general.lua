-- Everything else: devices, items, doors, misc messages.
-- Trigger functions for worlds/plugins/prometheus/general.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- The sharp noise of a piercing arrow cutting through space can be heard before * deposited.
function General_TheSharpNoiseOfAPiercing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/arrowImpact.ogg")
end

-- The starship completes surveying the planet.
function General_TheStarshipCompletesSurveyingThePlanet(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- The hum of the recharge falls silent as the batteries of the vehicle become full.
function General_TheHumOfTheRechargeFalls(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- You hear an odd whoosh as the stored charge is discarded.
function General_YouHearAnOddWhooshAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  Note("Charge discarded.")
end

-- The hum subsides and finally falls silent as the batteries finish recharging.
function General_TheHumSubsidesAndFinallyFalls(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- ^(.*?)turn(.*?)sink(.*?)on(.*?)wash(.*?)hands\.$
function General_TurnSinkOnWashHands(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/WashingHands.ogg")
end

-- * is carried into the room in the center of a flaming circle.
function General_IsCarriedIntoTheRoomIn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/FireBolt.ogg")
end

-- * reforms into the legendary human wizard... And disappears in a circle of flames!
function General_ReformsIntoTheLegendaryHumanWizard(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/FlameVanish.ogg")
end

-- * has restored you to full health!
function General_HasRestoredYouToFullHealth(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Health.ogg")
end

-- Movement fixed.
function General_MovementFixed(name, line, wildcards)
  if (ConfigTable.Settings.Roundtime == 1) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Roundtime.ogg")
  end
end

-- Fixed.
function General_Fixed(name, line, wildcards)
  if (ConfigTable.Settings.Roundtime == 1) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Roundtime.ogg")
  end
end

-- Roundtime fixed.
function General_RoundtimeFixed(name, line, wildcards)
  if (ConfigTable.Settings.Roundtime == 1) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Roundtime.ogg")
  end
end

-- ^(\d+) (second|minute) (stun|round)time\.$
function General_SecondMinuteStunRoundTime(name, line, wildcards)
  if (ConfigTable.Settings.Roundtime == 1) then
    if (string.match(wildcards[2], "minute")) then
      DoAfterSpecial((tonumber(wildcards[1]) * 60), 'CurrentGlobalSound = PlayGlobalSound("General/Misc/Roundtime.ogg")', sendto.script)
    elseif (string.match(wildcards[2], "second")) then
      DoAfterSpecial(wildcards[1], 'CurrentGlobalSound = PlayGlobalSound("General/Misc/Roundtime.ogg")', sendto.script)
    end
  end
end

-- You raise your status to *!
function General_YouRaiseYourStatusTo(name, line, wildcards)
  Execute("history_add All=" .. line)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/LevelUp.ogg")
end

-- A new poll has been opened. Use vote to answer it.
function General_ANewPollHasBeenOpened(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Poll.ogg")
end

-- I don't understand that.
function General_DonUnderstandThat(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Command"..math.random(1, 4)..".ogg")
end

-- * type*a complicated series of code*into * translator.
function General_TypeAComplicatedSeriesOfCode(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Socials/PyrianChitter"..math.random(1, 10)..".ogg")
end

-- A red light on the docking console turns on.
function General_ARedLightOnTheDocking(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- The yellow light turns to green.
function General_TheYellowLightTurnsToGreen(name, line, wildcards)
  StopSound(CurrentGlobalSound)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- * snatch*from the cold, cruel hands of space.
function General_SnatchFromTheColdCruelHands(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/SnatchArtifact"..math.random(1, 2)..".ogg")
end

-- * toggle*the starships alert status to a * state.
function General_ToggleTheStarshipsAlertStatusTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- You hear the hum fade as the weapons power down.
function General_YouHearTheHumFadeAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- The vibration ceases as the long-range laser powers down.
function General_TheVibrationCeasesAsTheLong(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- The roar of the engine calms as the starship completes its launch.
function General_TheRoarOfTheEngineCalms(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Background"..math.random(1, 5)..".ogg")
end

-- A low hum starts in the background as the batteries begin recharging.
function General_ALowHumStartsInThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- A soft hum starts somewhere within the bowels of the ship as the * banks are refilled.
function General_ASoftHumStartsSomewhereWithin(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/RefillingBanks.ogg")
end

-- The hum subsides as the * bank refilling completes.
function General_TheHumSubsidesAsTheBank(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- The low hum fades away as the shields finish recharging.
function General_TheLowHumFadesAwayAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- The rumble beneath your feet eases off as the refinery powers down.
function General_TheRumbleBeneathYourFeetEases(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- The ship slows down as it comes closer to the final destination.
function General_TheShipSlowsDownAsIt(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- The ship suddenly shoots out of the rift and into another sector. The rift rapidly shrinks and disappears.
function General_TheShipSuddenlyShootsOutOf(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Background"..math.random(1, 5)..".ogg")
end

-- * appears in a puff of smoke!
function General_AppearsInAPuffOfSmoke(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Smoke"..math.random(1, 3)..".ogg")
end

-- The ship slows down and you feel the sharp jolt as the ship touches down on the landing pad.
function General_TheShipSlowsDownAndYou(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- The low hum of the power transfer dies away, followed a split second later by a click as the power cable beneath the vehicle disconnects.
function General_TheLowHumOfThePower(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  Note("Recharge complete!")
end

-- You hear some clangs as the excavation equipment is retracted.
function General_YouHearSomeClangsAsThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Combat/Space/Reflectors3.ogg")
end

-- Now viewing monitoring satellite *. This satellite is monitoring *.
function General_NowViewingMonitoringSatelliteThisSatellite(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Satellite.ogg")
  Note("Satellite report of " .. wildcards[2] .. ":")
end

-- You receive * points!
function General_YouReceivePoints(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Points.ogg")
end

-- You*open *
function General_YouOpen(name, line, wildcards)
  if (string.match(wildcards[2], "container")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/ContainerOpen.ogg")
  elseif (string.match(wildcards[2], "food")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/FridgeOpen.ogg")
  elseif (string.match(wildcards[2], "oven")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/OvenDoorOpen.ogg")
  elseif (string.match(wildcards[2], "pot")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/ContainerOpen.ogg")
  elseif (string.match(wildcards[2], "drink mixer")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/DrinkMixerOpen.ogg")
  end
end

-- You*close *
function General_YouClose(name, line, wildcards)
  if (string.match(wildcards[2], "container")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/ContainerClose.ogg")
  elseif (string.match(wildcards[2], "food")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/FridgeClose.ogg")
  elseif (string.match(wildcards[2], "oven")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/OvenDoorClose.ogg")
  elseif (string.match(wildcards[2], "pot")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/ContainerClose.ogg")
  elseif (string.match(wildcards[2], "drink mixer")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/DrinkMixerClose.ogg")
  end
end

-- The hum subsides as * finish reloading.
function General_TheHumSubsidesAsFinishReloading(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- You have just received * Easter eggs as a gift! Found in your inventory!
function General_YouHaveJustReceivedEasterEggs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/EggHunt.ogg")
end

-- * enter*a shiny lift.
function General_EnterAShinyLift(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Movement.ogg")
end

-- * step*out of the lift.
function General_StepOutOfTheLift(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Movement.ogg")
end

-- * begin*scribbling something on a PBS. Inc. lottery ticket...
function General_BeginScribblingSomethingOnAPbs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Scribble.ogg")
end

-- Your command could not be executed at this time. *
function General_YourCommandCouldNotBeExecuted(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Traceback.ogg")
end

-- Distance: *.
function General_Distance(name, line, wildcards)
  if (tonumber(wildcards[1]) == 1) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Roundtime.ogg")
  end
end

-- Red lights on warning signs begin to flash, indicating that the ship is in the midst of a solar storm.
function General_RedLightsOnWarningSignsBegin(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Alarm.ogg")
end

-- The red lights on the solar storm warning signs stop flashing.
function General_TheRedLightsOnTheSolar(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- You begin your journey towards *.
function General_YouBeginYourJourneyTowards(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/SpeedwalkStart.ogg")
end

-- You arrive at *.
function General_YouArriveAt(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/SpeedwalkDestination.ogg")
end

-- * sanitation droid arrives.
function General_SanitationDroidArrives(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/SanitationDroidArrives.ogg")
end

-- * sanitation droid trundles around the area, collecting dropped items.
function General_SanitationDroidTrundlesAroundTheArea(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/SanitationDroidCollects.ogg")
end

-- * sanitation droid heads *.
function General_SanitationDroidHeads(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/SanitationDroidLeaves.ogg")
end

-- You hear a ghostly moan echoing through the vast reaches of space.*
function General_YouHearAGhostlyMoanEchoing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ghostSound.ogg")
end

-- You hear a ghostly moan echoing around you.
function General_YouHearAGhostlyMoanEchoing2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ghostMoan.ogg")
end

-- A long wailing cry shatters the silence.
function General_ALongWailingCryShattersThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ghostMoan.ogg")
end
