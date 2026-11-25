-- Activities: archaeology, pearl diving, shipwrecks, comets and asteroids, harvesting, star research, hatch cracking, derelicts, sifting and prospecting.
-- Trigger functions for worlds/plugins/prometheus/activities.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- * securely bolt* so it cannot be moved.
function Activities_SecurelyBoltSoItCannotBe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Asteroid/AnchorStart.ogg")
end

-- * remove*the bolts from * and pick*it up.
function Activities_RemoveTheBoltsFromAndPick(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Asteroid/AnchorRemove.ogg")
end

-- You hear a whirring coming from beneath you, followed by a loud click as the ship's asteroid anchor is drilled securely into the asteroid.
function Activities_YouHearAWhirringComingFrom(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Asteroid/AnchorEnd.ogg")
end

-- You hear a sharp scraping sound and look out to notice the asteroid anchor being removed from the solid rock.
function Activities_YouHearASharpScrapingSound(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Asteroid/AnchorRemove.ogg")
end

-- * carefully slide*into *
function Activities_CarefullySlideInto(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/Container.ogg")
end

-- You put * into * container*.
function Activities_YouPutIntoContainer(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/Container.ogg")
end

-- Through the window, you watch a starship probe remove a section of hull with its industrial-strength drill and saw attachments, just large enough for it to enter the ship.
function Activities_ThroughTheWindowYouWatchA(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Derelicts/ProbeDrill.ogg")
end

-- * place* UTF-Issue hatch cracker against *, and press a few buttons. The device's AI immediately begins to hack  into the vehicle's security systems.
function Activities_PlaceUtfIssueHatchCrackerAgainst(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/HatchCracking/HatchCrackStart.ogg")
  CurrentGlobalSound = PlayGlobalSound("Starship/HatchCracking/WaitForCrack.ogg")
end

-- * UTF-Issue hatch cracker displays, "Warning, a virus has been transmitted to this device!"
function Activities_UtfIssueHatchCrackerDisplaysWarning(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/HatchCracking/HatchCrackFailStart.ogg")
end

-- * UTF-Issue hatch cracker begins to spray sparks and glow omenously, then explodes in your hand!
function Activities_UtfIssueHatchCrackerBeginsTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/HatchCracking/HatchCrackFailEnd.ogg")
end

-- In no time at all, * UTF-Issue hatch cracker's AI has totally overpowered * security system and unlocked the airlock.
function Activities_InNoTimeAtAllUtf(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/HatchCracking/HatchCrackEnd.ogg")
end

-- You put your hands around * hatch repair drone and squeeze.
function Activities_YouPutYourHandsAroundHatch(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/HatchCracking/ActivateHatchRepairDrone.ogg")
end

-- * hatch repair drone unfolds slowly, revealing a wide aray of tools. It begins its work with a loud racket.
function Activities_HatchRepairDroneUnfoldsSlowlyRevealing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/HatchCracking/HatchRepairDroneActivationResponse.ogg")
end

-- * hatch repair drone replaces a broken hatch component with a spare.
function Activities_HatchRepairDroneReplacesABroken(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/HatchCracking/ReplacePartWithSpare.ogg")
end

-- * hatch repair drone connects to the computer and rewrites some infected code.
function Activities_HatchRepairDroneConnectsToThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/HatchCracking/ConnectAndRewrite.ogg")
end

-- * hatch repair drone welds some metal together.
function Activities_HatchRepairDroneWeldsSomeMetal(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/HatchCracking/Welding.ogg")
end

-- * hatch repair drone hammers some metal bits back into place.
function Activities_HatchRepairDroneHammersSomeMetal(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/HatchCracking/HammerMetal.ogg")
end

-- * hatch repair drone, its work complete, folds back up into a small ball.
function Activities_HatchRepairDroneItsWorkComplete(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/HatchCracking/DeactivateHatchRepairDrone.ogg")
end

-- The equipment returns to the ship with a clang.
function Activities_TheEquipmentReturnsToTheShip(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Harvesting/EquipmentReturning.ogg")
end

-- The harvesting equipment begins drilling deep into the asteroid's surface.
function Activities_TheHarvestingEquipmentBeginsDrillingDeep(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Harvesting/DrillingAsteroid"..math.random(1, 8)..".ogg")
end

-- The ship shakes softly as the comet harvesting equipment reaches out and begins harvesting the top of * of gases.
function Activities_TheShipShakesSoftlyAsThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Harvesting/DrillingAsteroid"..math.random(1, 8)..".ogg")
end

-- You watch the harvesting equipment unfold from underneath the vessel and begin moving toward the asteroid on your ship's viewscreen.
function Activities_YouWatchTheHarvestingEquipmentUnfold(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Harvesting/EquipmentUnfold.ogg")
end

-- You hear some clangs and whooshes as the harvesting equipment retracts back into the ship's bowels.
function Activities_YouHearSomeClangsAndWhooshes(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Harvesting/EquipmentReturning.ogg")
end

-- From where the equipment drilled in, a shower of rocks suddenly bursts out!
function Activities_FromWhereTheEquipmentDrilledIn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Harvesting/Explosion.ogg")
end

-- The ship lurches as a powerful cutting beam is launched to space.
function Activities_TheShipLurchesAsAPowerful(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Shipwrecks/BeamLaunch.ogg")
end

-- The ship rumbles as the beam carefully cuts its way into the wreck.
function Activities_TheShipRumblesAsTheBeam(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Shipwrecks/BeamCutting.ogg")
end

-- With a jolt, the beam returns to the ship.
function Activities_WithAJoltTheBeamReturns(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Shipwrecks/BeamJolt.ogg")
end

-- A smooth hum builds up in the background, and the unmistakeable sounds of gas being cleaned up fills the area.
function Activities_ASmoothHumBuildsUpIn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comets/GasCleanUp.ogg")
end

-- * thrust*shovel deep into the ground.
function Activities_ThrustShovelDeepIntoTheGround(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/Shovel"..math.random(1, 5)..".ogg")
end

-- * shovel*aside some freshly dug dirt, but all you find is a strange insect.
function Activities_ShovelAsideSomeFreshlyDugDirt(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/Cease.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/Insect"..math.random(1, 4)..".ogg")
end

-- * sigh*as the digging reveals nothing but insects.
function Activities_SighAsTheDiggingRevealsNothing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/Cease.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/Insect"..math.random(1, 4)..".ogg")
end

-- * shovel*aside the dug dirt, but find nothing underneath.
function Activities_ShovelAsideTheDugDirtBut(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/Cease.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/Insect"..math.random(1, 4)..".ogg")
end

-- You shovel the dug dirt aside, revealing *!
function Activities_YouShovelTheDugDirtAside(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/Cease.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/ArtifactFind.ogg")
  Note("Revealing " .. wildcards[1] .. "!")
end

-- The shovel produces a clear clang sound as it hits something underground.
function Activities_TheShovelProducesAClearClang(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/Cease.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/Clang.ogg")
end

-- * shovel indicates that the area is empty of artifacts.
function Activities_ShovelIndicatesThatTheAreaIs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/NothingHere.ogg")
  Note("This area is empty of artifacts.")
end

-- You think you might have found something... But when you shovel the dug dirt aside, nothing reveals.
function Activities_YouThinkYouMightHaveFound(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/Cease.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/NothingReveals.ogg")
end

-- You hear some clangs as the excavation equipment is deployed.
function Activities_YouHearSomeClangsAsThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/Shovel"..math.random(1, 5)..".ogg")
end

-- You hear a loud clang as something under the vehicle snaps.
function Activities_YouHearALoudClangAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Harvesting/Explosion.ogg")
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Damaged.ogg")
end

-- You remove*from the water!
function Activities_YouRemoveFromTheWater(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/PearlDiving/PearlFind.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/PearlDiving/Found"..math.random(1, 7)..".ogg")
  Note("Revealing " .. wildcards[1] .. "!")
end

-- You pull*from the water and slip it into*!
function Activities_YouPullFromTheWaterAnd(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("sift/sift"..math.random(1, 7)..".ogg")
  Note("Safely placed " .. wildcards[1] .. " in " .. wildcards[2] .. "!")
end

-- You start searching for valuable items with*sifting net.
function Activities_YouStartSearchingForValuableItems(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("sift/SiftingNet.ogg")
end

-- * div*into the water.
function Activities_DivIntoTheWater(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/PearlDiving/Dive"..math.random(1, 5)..".ogg")
  StopSound(CurrentRoomSound)
  CurrentRoomSound = PlayRoomSound("Misc/PearlDiving.ogg")
end

-- *put*into*oceanography container.
function Activities_PutIntoOceanographyContainer(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/PearlDiving/OceanographyContainer.ogg")
end

-- The scanner indicates that the current coordinates are empty of valuable items.
function Activities_TheScannerIndicatesThatTheCurrent(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/PearlDiving/NothingHere.ogg")
end

-- * begin*moving * underwater shovel through the water and deep into the ground.
function Activities_BeginMovingUnderwaterShovelThroughThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/Shovel"..math.random(1, 5)..".ogg")
  if not string.match(wildcards[1], "You") then
    Note(line)
  end
end

-- * stop*digging, nothing as a result.
function Activities_StopDiggingNothingAsAResult(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/PearlDiving/Cease.ogg")
  if not string.match(wildcards[1], "You") then
    Note(line)
  end
end

-- Valuable material found! Depth *.
function Activities_ValuableMaterialFoundDepth(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/PearlDiving/PearlLocated.ogg")
end

-- You begin swimming toward the surface.
function Activities_YouBeginSwimmingTowardTheSurface(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/PearlDiving/Resurface.ogg")
  StopSound(CurrentRoomSound)
  CurrentRoomSound = PlayRoomSound("Misc/Ocean.ogg")
end

-- * swims onto the shore.
function Activities_SwimsOntoTheShore(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/PearlDiving/Resurface.ogg")
end

-- An alert is displayed across your suit's glasses: *
function Activities_AnAlertIsDisplayedAcrossYour(name, line, wildcards)
  if (string.match(wildcards[1], "20 minutes")) then
    CurrentGlobalSound = PlayGlobalSound("General/PearlDiving/RunningOutOfOxygen1.ogg")
  elseif (string.match(wildcards[1], "10 minutes")) then
    CurrentGlobalSound = PlayGlobalSound("General/PearlDiving/RunningOutOfOxygen2.ogg")
  elseif (string.match(wildcards[1], "5 minutes")) then
    CurrentGlobalSound = PlayGlobalSound("General/PearlDiving/RunningOutOfOxygen3.ogg")
  elseif (string.match(wildcards[1], "2 minutes")) then
    CurrentGlobalSound = PlayGlobalSound("General/PearlDiving/RunningOutOfOxygen4.ogg")
  elseif (string.match(wildcards[1], "1 minute")) then
    CurrentGlobalSound = PlayGlobalSound("General/PearlDiving/RunningOutOfOxygen5.ogg")
  end
  Note("Alert: Oxygen for " .. wildcards[1])
end

-- You activate a high-powered infrared laser beam.
function Activities_YouActivateAHighPoweredInfrared(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/StarResearching/LActivate.ogg")
end

-- * deftly hits a button on an infrared laser beam control board, activating the high-powered beam.
function Activities_DeftlyHitsAButtonOnAn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/StarResearching/LActivate.ogg")
end

-- The room lights up with a beautiful red glow as the starship fires an infrared laser beam into space towards a star.
function Activities_TheRoomLightsUpWithA(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/StarResearching/LFiring.ogg")
end

-- You notice the star begin to glow a blinding red.
function Activities_YouNoticeTheStarBeginTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/StarResearching/LBlinding.ogg")
end

-- The pulsating light radiates as it becomes steady.
function Activities_ThePulsatingLightRadiatesAsIt(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/StarResearching/LPulsating.ogg")
end

-- The pulsating of the lights grows steady.
function Activities_ThePulsatingOfTheLightsGrows(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/StarResearching/LSteady.ogg")
end

-- Rays of light pulsate as the starship continues to fire the infrared laser beam at the star.
function Activities_RaysOfLightPulsateAsThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/StarResearching/LPulsating.ogg")
end

-- Suddenly, the rays of light begin pulsating quickly, and it seems as if the star is disintegrating right before your eyes.
function Activities_SuddenlyTheRaysOfLightBegin(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/StarResearching/LRapid.ogg")
end

-- The rays of light dwindle down to nothing as the starship's infrared laser beam powers down.
function Activities_TheRaysOfLightDwindleDown(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/StarResearching/LDeactivate.ogg")
end

-- The starship's computer prints * of the star research data.
function Activities_TheStarshipComputerPrintsOfThe(name, line, wildcards)
  total = tonumber(prometheus.util.Explode(wildcards[1], " ")[1])
  for i = 1, total do
    CurrentGlobalSound = PlayGlobalSound("Starship/StarResearching/Printer.ogg")
  end
end

-- The scanning console emits a series of beeps before printing *.
function Activities_TheScanningConsoleEmitsASeries(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/StarResearching/Printer.ogg")
  DoAfterSpecial(2, 'CurrentGlobalSound = PlayGlobalSound("Starship/StarResearching/SnatchPaper.ogg")', sendto.script)
end

-- The computer beeps and prints out a *
function Activities_TheComputerBeepsAndPrintsOut(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/StarResearching/Printer.ogg")
  DoAfterSpecial(2, 'CurrentGlobalSound = PlayGlobalSound("Starship/StarResearching/SnatchPaper.ogg")', sendto.script)
end

-- * remove*a small piece of paper containing strange symbols from the printer.
function Activities_RemoveASmallPieceOfPaper(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/StarResearching/SnatchPaper.ogg")
end

-- * datapad prints a peace of paper titled *
function Activities_DatapadPrintsAPeaceOfPaper(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/StarResearching/Printer.ogg")
end

-- You hear an odd noise coming from the direction of the ship's hatch.
function Activities_YouHearAnOddNoiseComing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/HatchCracking/HatchCracked.ogg")
end

-- You place * in *
function Activities_YouPlaceIn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/Container.ogg")
end

-- A hum builds up for a second, but quickly subsides; apparently nothing was found.
function Activities_AHumBuildsUpForA(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Harvesting/NoMinerals.ogg")
end

-- Prospecting (issue #8): Kendal's triggers call these three (her choice, so spdebug names them).

-- Every panning line (scooping, swirling, tilting, lifting the pan out and so on).
function Activities_ProspectingPanning(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Prospecting/panning"..math.random(1, 6)..".ogg")
end

-- You touch a small button on the handle of * prospecting pan, ... (the scanner)
function Activities_ProspectingScan(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Prospecting/scan"..math.random(1, 6)..".ogg")
end

-- You carefully tuck * inside of * gold prospecting container.
function Activities_ProspectingNugget(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Prospecting/GetNugget.ogg")
end
