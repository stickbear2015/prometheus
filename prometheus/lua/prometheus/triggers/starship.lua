-- Starship sounds: movement, docking, systems, sensors, mining and repairs.
-- Trigger functions for worlds/plugins/prometheus/starship.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- The application console beeps as * complete*submitting an application.
function Starship_TheApplicationConsoleBeepsAsComplete(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/ScanSuccess.ogg")
end

-- Beeps can be heard as the starship surveys the planet.
function Starship_BeepsCanBeHeardAsThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Scanning.ogg")
end

-- Beeps and clicks can be heard as the starships surveyor activates.
function Starship_BeepsAndClicksCanBeHeard(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Scanning.ogg")
end

-- ^\(From outside\: (.*)\)$
function Starship_FromOutside(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/CameraFeed.ogg")
  Note("[Camera] " .. wildcards[1])
end

-- ^\(In (.*)\: (.*)\)$
function Starship_In(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/CameraFeed.ogg")
  Note("[Camera] " .. wildcards[2] .. " (" .. wildcards[1] .. ")")
end

-- You hear a humming noise *.
function Starship_YouHearAHummingNoise(name, line, wildcards)
  if (wildcards[1] == "as the docking bay door opens") then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/DockingBayDoorOpen.ogg")
  elseif (wildcards[1] == "as the docking bay door closes") then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/DockingBayDoorClose.ogg")
  end
end

-- The humm dies down as the starship's powerup fails.
function Starship_TheHummDiesDownAsThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/BadCell.ogg")
end

-- You hear the roar of * starship from outside.
function Starship_YouHearTheRoarOfStarship(name, line, wildcards)
  if (wildcards[1] == "launching" or wildcards[1] == "undocking") then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/OtherLaunching"..math.random(1, 3)..".ogg",
    math.random(-100, 100))
  elseif (wildcards[1] == "landing" or wildcards[1] == "docking") then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/OtherLanding"..math.random(1, 3)..".ogg", math.random(-100, 100))
  end
end

-- A message is displayed in bright red on the screen, "*"
function Starship_AMessageIsDisplayedInBright(name, line, wildcards)
  Execute("history_add All=" .. wildcards[1])
  Execute("history_add Vehicles=" .. wildcards[1])
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Announce"..math.random(1, 7)..".ogg")
  CurrentCombatSound = PlayCombatSound("Space/OtherDestroyed"..math.random(1, 8)..".ogg")
  Note(wildcards[1])
end

-- What the ship's computer can detect in the sector. Unlike the list below, every
-- entry that fits is played, one after another.
SECTOR_DETECTIONS = {
  { has = "enemy starship", sound = "Starship/Computer/EnemyDetected" },
  { has = "artifact", sound = "Starship/Computer/Artifact" },
  { has = "friendly", sound = "Starship/Computer/FriendlyShip" },
  { has = " relic", sound = "Starship/Computer/Relic" },
  { has = "comet", sound = "Starship/Computer/Comet" },
  { has = "shipwreck", sound = "Starship/Computer/Shipwreck" },
  { has = "planet", sound = "Starship/Computer/Planet" },
  { has = "spacestation", sound = "Starship/Computer/SpaceStation" },
  { has_lower = " star ", sound = "Starship/Computer/Star" },
  { has = "derelict starship", sound = "Starship/Derelicts/AlienStarship" },
  { has = "asteroid", sound = "Starship/Computer/Asteroid" },
  { has = "debris", sound = "Starship/Computer/Debris" },
  { has = "spacebear", sound = "Starship/Computer/Spacebear" },
}

-- Computer announcements, checked from top to bottom; only the first entry that fits
-- is played. (See common.lua for what each field means.)
COMPUTER_ANNOUNCEMENTS = {
  { has = "detected in the sector", play = function(text)
      for _, entry in ipairs(SECTOR_DETECTIONS) do
        if FindSoundEntry({ entry }, text) then PlaySoundEntry(entry, text) end
      end
    end },
  { has = "generators have completed their charging cycle", sound = "General/Misc/Beep", versions = 5 },
  { has = "Valuable material found" },  -- no sound
  { has = "successfully grabbed", sound = "Starship/Misc/Salvage", versions = 3 },
  { has = "Beam locked", sound = "Starship/Computer/Warning" },
  { has = "debris cloud", play = function(text)
      if string.match(text, "partially salvaged") or string.match(text, "completely salvaged") then
        CurrentGlobalSound = PlayGlobalSound("Vehicle/Store.ogg")
      end
    end },
  { has = "has been salvaged", play = function(text)
      if ConfigTable.Settings.SalvagingMessages == 0 and string.match(text, "and prepared for future use") then
        CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Prepared.ogg")
      end
    end },
  { has = "A present disruption field prevents safe travel out of the sector", sound = "Starship/Move/NAVI_Interrupted" },
  { has = "This weapon system is disabled", sound = "General/Misc/Cancel" },
  { has = "Artifacts retrieved", play = function(text)
      if not string.match(text, "nothing") then
        CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Salvage" .. math.random(1, 3) .. ".ogg")
      end
    end },
  { any = { "Target has moved from the locked coordinates", "^Miss.$", "Target moved", "Firing incomplete due to target moving" },
    sound = "Space/LostLock", combat = true },
  { any = { "There is no target at the locked coordinates", "Firing aborted" }, sound = "General/Misc/Cancel" },
  { has = "This ship transmits", sound = "General/Channels/Sector" },
  { has = "This starship is not equipped with the landing equipment needed to land on asteroids", sound = "Starship/Move/LandingImpossible" },
  { has_lower = "that component is damaged beyond repair", sound = "Starship/Computer/Warning" },
  { has_lower = "recharging", sound = "Starship/Misc/BatteryRecharging" },
  { has_lower = "recharge complete", sound = "General/Misc/Beep", versions = 5 },
  { has = "deployed for repair of", sound = "Starship/Computer/RepairStart" },
  { has = "completed repair of", sound = "Starship/Computer/RepairComplete" },
  { has = "Current repair aborted", sound = "Starship/Computer/RepairAborted" },
  { has = "banks empty", sound = "Starship/Computer/Warning" },
  { has = "WARNING", sound = "Starship/Computer/Warning" },
  { has = "cleared the solar storm", sound = "General/Misc/Beep", versions = 5 },
  { has = "recharged", sound = "General/Misc/Beep", versions = 5 },
  { has = "Autopilot engaged", sound = "General/Devices/Activate" },
  { has = "Autopilot disengaged", sound = "General/Devices/Deactivate" },
  { has_lower = "deploying asteroid anchor complete", sound = "General/Misc/Beep", versions = 5 },
  { has_lower = "damage taken from an explosion on the surface", sound = "Starship/Harvesting/EquipmentDamaged" },  -- no such file yet
  { has_lower = "no minerals detected", sound = "Starship/Harvesting/NoMinerals" },
  { has_lower = "is not equipped for asteroid landing", sound = "Starship/Move/LandingImpossible" },
  { has_lower = "landing impossible when", sound = "Starship/Move/LandingImpossible" },
  { has_lower = "charge levels reaching critical", sound = "Starship/Computer/LowCharge", versions = 2 },
  { any_lower = { "storage full", "lack of storage space" }, sound = "Starship/Misc/StorageFull" },
  { has = "Mission access code", has_lower = "accepted", sound = "Starship/Computer/PiercingTone" },
  { has = "Mission completed", sound = "Music/", versions = 63, also = { sound = "General/Misc/Congratulations" } },
  { has = "Not enough shells left to fire", sound = "Starship/Computer/Warning" },
  { has_lower = "cannot refine all the material in the storage compartment", sound = "Vehicle/RefineryFull" },
  { has_lower = "initiating asteroid haul to", sound = "Starship/Computer/Keyboard", versions = 7,
    also = { sound = "Starship/Move/HaulAsteroid", versions = 2 } },
  { has_lower = "on shipwreck", sound = "General/Shipwrecks/BeamLockedOn" },
  -- "%-" is a plain hyphen ("-" on its own is special in Lua patterns).
  { has_lower = "self%-destruct sequence initiated", sound = "Starship/Misc/SelfDestructStart" },
  { has = "^Sixty.$", sound = "Starship/Misc/SelfDestructSixty" },  -- no such file yet
  { has = "^Thirty.$", sound = "Starship/Misc/SelfDestructThirty" },
  { has = "^Ten.$", sound = "Starship/Misc/SelfDestructTen" },
  { has = "^Five.$", sound = "Starship/Misc/SelfDestructFive" },
  { has = "^Four.$", sound = "Starship/Misc/SelfDestructFour" },
  { has = "^Three.$", sound = "Starship/Misc/SelfDestructThree" },
  { has = "^Two.$", sound = "Starship/Misc/SelfDestructTwo" },
  { has = "^One.$", sound = "Starship/Misc/SelfDestructOne" },
  { has_lower = "beginning ground dock", sound = "Starship/Move/DockingBayDoorOpen" },
  { has_lower = { "harvesting aborted", "damaged" }, sound = "General/Comets/Explosion" },
  { has_lower = "harvested", sound = "Starship/Misc/Salvage", versions = 3 },
  { has_lower = "spacepowerup mode engaged", sound = "Starship/Misc/SpacePowerStartUp" },
  { has_lower = "powering down due to lack of charge", sound = "Starship/Computer/LowCharge", versions = 2 },
  { has_lower = "charge running critical", sound = "Starship/Computer/LowCharge", versions = 2 },
  { has_lower = "hit on", sound = "Space/OtherHit", versions = 4, combat = true },
  { has_lower = "weapon fire blocked by shields", sound = "Space/FireReflected", combat = true },
  { has_lower = "grenade firing complete", sound = "Ground/GrenadeExplode", combat = true },
  { has_lower = "computer piping", play = function(text)
      if string.match(text, "enabled") then
        CurrentGlobalSound = PlayGlobalSound("Starship/Computer/PipeOn.ogg")
      elseif string.match(text, "disabled") then
        CurrentGlobalSound = PlayGlobalSound("Starship/Computer/PipeOff.ogg")
      end
    end },
  { has = "Locked onto", sound = "Space/LockedOnOther", combat = true },
  { has = { "Target out of", "range" }, sound = "General/Misc/Cancel" },
  { has = "Detected an attempt to launch the ship while drunk", sound = "General/Misc/Cancel" },
  { has = "Firmware upgrade complete", sound = "Combat/Space/ArmorPiercingChipDone" },
  { has = "Scanning", sound = "Starship/Misc/Scanning" },
  { has = "collided with", sound = "Space/YouHit", versions = 9, combat = true },
  { has = "Gathering data", sound = "Starship/Misc/Scanning" },
}

-- The computer announces, "*"
-- Every announcement is shown, added to the All and Computer Announcements buffers, and
-- plays the announcement chime; then COMPUTER_ANNOUNCEMENTS may add its own sound.
-- These announcements are always shown. The old GrabbingMessages, SalvagingMessages and
-- HarvestingMessages settings (config.lua) have no command or key to switch them, so they
-- always stay 0; don't make them hide announcements, or every player would lose them.
function Starship_TheComputerAnnounces(name, line, wildcards)
  local text = wildcards[1]
  Note(text)
  Execute("history_add All=Computer Announcement: " .. text)
  Execute("history_add Computer Announcements=" .. text)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Announce" .. math.random(1, 7) .. ".ogg")
  local entry = FindSoundEntry(COMPUTER_ANNOUNCEMENTS, text)
  if entry then
    PlaySoundEntry(entry, text)
  end
end

-- ^Computer in (.*)\, "(.*)"$
function Starship_ComputerIn(name, line, wildcards)
  Execute("history_add All=" .. wildcards[2] .. " (" .. wildcards[1] .. ")")
  Execute("history_add Computer Announcements=" .. wildcards[2] .. " (" .. wildcards[1] .. ")")
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Announce"..math.random(1, 7)..".ogg")
  Note(wildcards[2] .. " (" .. wildcards[1] .. ")")
end

-- The low hum of the shields recharging abruptly ends.
function Starship_TheLowHumOfTheShields(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/RepairAborted.ogg")
end

-- There are no * left in the launchers.
function Starship_ThereAreNoLeftInThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Warning.ogg")
end

-- * damaged beyond repair.
function Starship_DamagedBeyondRepair(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Warning.ogg")
end

-- There is inadequate amount of ammunition left in the starship for a reload.
function Starship_ThereIsInadequateAmountOfAmmunition(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Warning.ogg")
end

-- * the starship's salvage scanners, which begin scanning the area for debris.
function Starship_TheStarshipSalvageScannersWhichBegin(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
  if (string.match(string.lower(wildcards[1]), "you activate")) then return
  else Note(line) end
end

-- * begin*to install * into the ships systems.
function Starship_BeginToInstallIntoTheShips(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Report"..math.random(1, 4)..".ogg")
end

-- * finish*installing *
function Starship_FinishInstalling(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Report"..math.random(1, 4)..".ogg")
end

-- What the computer reports. Checked from top to bottom; the first entry that fits is
-- played. (See common.lua for what each field means.)
COMPUTER_REPORTS = {
  { has = "completed repair of", sound = "Starship/Computer/RepairComplete" },
  { has = "there is no debris", sound = "Starship/Computer/NoDebris" },  -- no such file yet
  { has = "starship probe", sounds = {
      { has = "destroyed by", sound = "Combat/Space/OtherDestroyed", versions = 8 },
      { has = "hacked into", sound = "Starship/Derelicts/Hacked", pan = true },
      { has = "Attempting to retreat", sound = "Starship/Derelicts/DestructionTriggered" },
      { has = "deployed", sound = "Starship/Derelicts/Probe", versions = 3 },
      { has = "discovered an artifact", sound = "Starship/Computer/Artifact", pan = true },
      { has = "returned to the ship", sound = "Starship/Derelicts/ProbeReturn" },
    } },
  { has = "is 1 unit away", sound = "Starship/Computer/OneUnitAway" },
  { has = "destroyed", sounds = {
      { has = "X-Loritan", sound = "Space/OtherDestroyed", versions = 8, combat = true },
      { sound = "Combat/Space/OtherDestroyed", versions = 8 },  -- any other ship
    } },
  { has = "no space for the debris", sound = "Starship/Misc/StorageFull" },
  { has = "Easter egg", sound = "General/Misc/EggItem" },
}

-- The computer reports that *
-- Every report is added to the All and Computer Reports buffers and plays the report
-- chime; COMPUTER_REPORTS may add its own sound. Then it's shown.
function Starship_TheComputerReportsThat(name, line, wildcards)
  local text = wildcards[1]
  Execute("history_add All=Computer Reports: " .. text)
  Execute("history_add Computer Reports=" .. text)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Report" .. math.random(1, 4) .. ".ogg")
  local entry = FindSoundEntry(COMPUTER_REPORTS, text)
  if entry then
    PlaySoundEntry(entry, text)
  end
  Note(text)
end

-- The computer emits a piercing tone, alerting you that a starship has been detected in the sector's boundries.
function Starship_TheComputerEmitsAPiercingTone(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/PiercingTone.ogg")
end

-- You hear several loud thuds as a salvaging line is deployed into space.
function Starship_YouHearSeveralLoudThudsAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/DeploySalvage.ogg")
end

-- Please do not command stack.
function Starship_PleaseDoNotCommandStack(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Warning.ogg")
end

-- Checking to see if your * is broken...
function Starship_CheckingToSeeIfYourIs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- Checking movement...
function Starship_CheckingMovement(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- Can't find *.
function Starship_CanFind(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/NothingHere.ogg")
end

-- No matching objects to "*".
function Starship_NoMatchingObjectsTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/NothingHere.ogg")
end

-- * pull*a series of straps around * and securely buckle* into * seat.
function Starship_PullASeriesOfStrapsAround(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Buckle"..math.random(1, 3)..".ogg")
end

-- * release*the buckle of * seatbelt, causing it to retract back into * seat.
function Starship_ReleaseTheBuckleOfSeatbeltCausing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Unbuckle"..math.random(1, 3)..".ogg")
end

-- * quickly doubletap*a button on top of *
function Starship_QuicklyDoubletapAButtonOnTop(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/MiniKeyboard.ogg")
end

-- * flick*a*switch on *.
function Starship_FlickASwitchOn(name, line, wildcards)
  if (string.match(wildcards[4], "radio microphone")) then
    if (string.match(wildcards[4], "turning on")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Misc/RadioOn.ogg")
    elseif (string.match(wildcards[4], "turning off")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Misc/RadioOff.ogg")
    end
  else
    if (string.match(wildcards[4], "enabling")) then
      CurrentGlobalSound = PlayGlobalSound("General/Devices/Activate.ogg")
    elseif (string.match(wildcards[4], "disabling")) then
      CurrentGlobalSound = PlayGlobalSound("General/Devices/Deactivate.ogg")
    end
  end
end

-- You notice a faint hum as the starship orients its asteroid anchor into place.
function Starship_YouNoticeAFaintHumAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Asteroid/AnchorStart.ogg")
end

-- * begin*maneuvering the starship onto an asteroid.
function Starship_BeginManeuveringTheStarshipOntoAn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/LandAsteroid.ogg")
end

-- * tap*a series of buttons, * the starship's power.
function Starship_TapASeriesOfButtonsThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- * tap*the unlock button on the grabbing console, causing the locked cutting beam to begin moving again.
function Starship_TapTheUnlockButtonOnThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- The ship lurches as a powerful cutting beam is launched into space.
function Starship_TheShipLurchesAsAPowerful(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/SalvageLaunch.ogg")
end

-- A slight hum can be heard as an artifact retrieval tube is deployed into space.
function Starship_ASlightHumCanBeHeard(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/SalvageLaunch.ogg")
end

-- * press*some buttons on * with *.
function Starship_PressSomeButtonsOnWith(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/MiniKeyboard.ogg")
end

-- You tap some buttons on * hypernet browser with * touchscreen and the screen flashes, '*'
function Starship_YouTapSomeButtonsOnHypernet(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/MiniKeyboard.ogg")
  Note(wildcards[3])
end

-- Displaying docked starships:
function Starship_DisplayingDockedStarships(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Debris scanner report for the current sector:
function Starship_DebrisScannerReportForTheCurrent(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Items in the storage compartment:
function Starship_ItemsInTheStorageCompartment(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- There is no trash in the storage compartment. The size of the storage compartment is * units.
function Starship_ThereIsNoTrashInThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Combat mission
function Starship_CombatMission(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Record for *
function Starship_RecordFor(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Available starship probes: *
function Starship_AvailableStarshipProbes(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- There is no debris to refine.
function Starship_ThereIsNoDebrisToRefine(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- A barely audible hum starts as the refiner begins its work.
function Starship_ABarelyAudibleHumStartsAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/RefineryStart.ogg")
end

-- The hum stops as the refiner completes its work.
function Starship_TheHumStopsAsTheRefiner(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/RefineryEnd.ogg")
end

-- Nothing is currently being constructed.
function Starship_NothingIsCurrentlyBeingConstructed(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Battery type: *
function Starship_BatteryType(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Current charge: *
function Starship_CurrentCharge(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Defense system information for *:
function Starship_DefenseSystemInformationFor(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- The following items are in the cargo hold:
function Starship_TheFollowingItemsAreInThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- There is nothing in the * hold. *
function Starship_ThereIsNothingInTheHold(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
  Note(wildcards[2])
end

-- Available units of refined material: * out of *
function Starship_AvailableUnitsOfRefinedMaterialOut(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- The refinery tanks are * full *
function Starship_TheRefineryTanksAreFull(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- ^You hear several loud thuds as automated drones (load|remove) cargo (from|into) the storage room\.$
function Starship_YouHearSeveralLoudThudsAs2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/TransferStart.ogg")
end

-- A drone loads * onto its platform and carries it away.
function Starship_ADroneLoadsOntoItsPlatform(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Transfer"..math.random(1, 3)..".ogg")
end

-- The thuds coming from *.
function Starship_TheThudsComingFrom(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/TransferEnd.ogg")
end

-- The clicks abruptly stop as the transfer finishes.
function Starship_TheClicksAbruptlyStopAsThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/TransferEnd.ogg")
end

-- A loud thud can be heard from the storage room as a piece of debris is deposited by the salvaging line.
function Starship_ALoudThudCanBeHeard(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Salvage"..math.random(1, 3)..".ogg")
end

-- You retrieve a weapons status readout.
function Starship_YouRetrieveAWeaponsStatusReadout(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Status for *
function Starship_StatusFor(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Charge readout:
function Starship_ChargeReadout(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Security status for *:
function Starship_SecurityStatusFor(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Engine Speed: *
function Starship_EngineSpeed(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Starship component Damage:
function Starship_StarshipComponentDamage(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Weapon Damage:
function Starship_WeaponDamage(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- * pull*up an image of the starship's status report on a screen built-into the main control board.
function Starship_PullUpAnImageOfThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- * furiously input*into a weapon locking console.
function Starship_FuriouslyInputIntoAWeaponLocking(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
  if not string.match(wildcards[1], "You") then
    Note(line)
  end
end

-- You hear several sliding noises as the reflector plates *
function Starship_YouHearSeveralSlidingNoisesAs(name, line, wildcards)
  if (string.match(wildcards[1], "surround the hull")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/PanelsOn.ogg")
  elseif (string.match(wildcards[1], "around the hull are retracted")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/PanelsOff.ogg")
  end
end

-- You hear a barely audible vibration followed by a * the ship.
function Starship_YouHearABarelyAudibleVibration(name, line, wildcards)
  if (string.match(wildcards[1], "around")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/PanelsOn.ogg")
  elseif (string.match(wildcards[1], "retract")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/PanelsOff.ogg")
  end
end

-- You hear a vibration as the solar recharge completes and the solar receptors retract back into the ship with an audible click.
function Starship_YouHearAVibrationAsThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/PanelsOff.ogg")
end

-- You hear some clangs and drilling sounds as the replacement * is installed.
function Starship_YouHearSomeClangsAndDrilling(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/ReplacingComponent.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Archaeology/Clang.ogg")
  Note("Replacement " .. wildcards[1] .. " is installed.")
end

-- You're not in space!
function Starship_YouReNotInSpace(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/NotInSpace.ogg")
end

-- You should be in space.
function Starship_YouShouldBeInSpace(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/NotInSpace.ogg")
end

-- The * isn't in space.
function Starship_TheIsnInSpace(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/NotInSpace.ogg")
end

-- The * is not in space.
function Starship_TheIsNotInSpace(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/NotInSpace.ogg")
end

-- You can only do that in space.
function Starship_YouCanOnlyDoThatIn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/NotInSpace.ogg")
end

-- The * is not in the required conditions to use this function.
function Starship_TheIsNotInTheRequired(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/NotInSpace.ogg")
end

-- The * should be in space before * wormhole transport console may be activated.
function Starship_TheShouldBeInSpaceBefore(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/NotInSpace.ogg")
end

-- * has * the sector.
function Starship_HasTheSector(name, line, wildcards)
  if (string.match(wildcards[2], "entered")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/EnterSector"..math.random(1, 2)..".ogg")
  elseif (string.match(wildcards[2], "jumped into")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/EnterSector"..math.random(1, 2)..".ogg")
  elseif (string.match(wildcards[2], "left")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/ExitSector"..math.random(1, 2)..".ogg")
  elseif (string.match(wildcards[2], "jumped out of")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/ExitSector"..math.random(1, 2)..".ogg")
  end
end

-- * has * the sector through an unrecorded field.
function Starship_HasTheSectorThroughAnUnrecorded(name, line, wildcards)
  if (string.match(wildcards[1], "X-Loritan") and string.match(wildcards[2], "entered")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/EnterSector"..math.random(1, 2)..".ogg")
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/EnemyDetected.ogg")
  elseif (string.match(wildcards[2], "jumped into")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/EnterSector"..math.random(1, 2)..".ogg")
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/EnemyDetected.ogg")
  elseif (string.match(wildcards[2], "left")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/ExitSector"..math.random(1, 2)..".ogg")
  elseif (string.match(wildcards[1], "X-Loritan") and string.match(wildcards[2], "jumped out of")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/ExitSector"..math.random(1, 2)..".ogg")
  end
end

-- * has * hyperspace.
function Starship_HasHyperspace(name, line, wildcards)
  if (string.match(wildcards[2], "entered")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/ExitSector"..math.random(1, 2)..".ogg")
  elseif (string.match(wildcards[2], "exitted")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/EnterSector"..math.random(1, 2)..".ogg")
  end
end

-- * has * stargate.
function Starship_HasStargate(name, line, wildcards)
  if (string.match(wildcards[2], "entered")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/ExitSector"..math.random(1, 2)..".ogg")
  elseif (string.match(wildcards[2], "exitted")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/EnterSector"..math.random(1, 2)..".ogg")
  end
end

-- A chime sounds, indicating that somebody has entered an airlock.
function Starship_AChimeSoundsIndicatingThatSomebody(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/AirlockChime.ogg")
  Note("Someone has entered the airlock.")
end

-- You feel a slight jolt as the ship begins to move through the open bay door, and into open space.
function Starship_YouFeelASlightJoltAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/DockingBayDoorOpen.ogg")
end

-- You feel a slight jolt as the other ship begins to move through the open bay door, and into open space.
function Starship_YouFeelASlightJoltAs2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/DockingBayDoorOpen.ogg")
end

-- You feel a faint vibration coming from the direction of the ships docking bay.
function Starship_YouFeelAFaintVibrationComing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/DockingBayDoorOpen.ogg")
end

-- You feel a slight pull as the ship is expeled from the docking bay.
function Starship_YouFeelASlightPullAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/DockingBayDoorClose.ogg")
end

-- You feel a slight jolt as the ship sets down in a docking bay.
function Starship_YouFeelASlightJoltAs3(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/DockingBayDoorClose.ogg")
end

-- * make*some selections on the docking console. The red light turns to yellow.
function Starship_MakeSomeSelectionsOnTheDocking(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/MiniKeyboard.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- Choosing * (Status: powered *).
function Starship_ChoosingStatusPowered(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/MiniKeyboard.ogg")
end

-- The smooth hum of the engines builds up a bit as the ship begins moving.
function Starship_TheSmoothHumOfTheEngines(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/Accelerate.ogg")
end

-- The hum of the engines settles down as the ship stops moving.
function Starship_TheHumOfTheEnginesSettles(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/Decelerate.ogg")
end

-- You hear the sound of the ship's engine as you are propelled toward space.
function Starship_YouHearTheSoundOfThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/YouLaunch"..math.random(1, 4)..".ogg")
end

-- You feel the starship accelerate as it moves toward a *
function Starship_YouFeelTheStarshipAccelerateAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/YouLand"..math.random(1, 2)..".ogg")
end

-- That space is occupied.
function Starship_ThatSpaceIsOccupied(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/SameSpace.ogg")
end

-- Those coordinates are occupied by this ship.
function Starship_ThoseCoordinatesAreOccupiedByThis(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/SameSpace.ogg")
end

-- You hear a dull roar as the ship's sublight drive propels the ship toward its destination.
function Starship_YouHearADullRoarAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/SublightExt.ogg")
end

-- * has initiated an intrasector sublight jump.
function Starship_HasInitiatedAnIntrasectorSublightJump(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/SublightExt.ogg")
end

-- The dull roar of the sublight drive fades away as the ship reaches a destination.
function Starship_TheDullRoarOfTheSublight(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Background"..math.random(1, 5)..".ogg")
end

-- * float*out into space.
function Starship_FloatOutIntoSpace(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/AirlockExit.ogg")
end

-- * out of the ship's hatch.
function Starship_OutOfTheShipHatch(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/AirlockExit.ogg")
end

-- * place*hand against a sensor on * and *.
function Starship_PlaceHandAgainstASensorOn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Hatch4.ogg")
end

-- * out from the hatch of *.
function Starship_OutFromTheHatchOf(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/AirlockExit.ogg")
end

-- * board*through the unlocked hatch.
function Starship_BoardThroughTheUnlockedHatch(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Hatch4.ogg")
end

-- * walk*out into space.
function Starship_WalkOutIntoSpace(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/AirlockExit.ogg")
end

-- The hum in the background builds up a bit as the pressurizing systems prepare for shutdown.
function Starship_TheHumInTheBackgroundBuilds(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/CycleStart.ogg")
end

-- The hum dies down as the pressurizing system shutdown completes.
function Starship_TheHumDiesDownAsThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/AirEnd.ogg")
end

-- A low, almost unnoticeable hum becomes audible in the background as the pressurizing systems are activated.
function Starship_ALowAlmostUnnoticeableHumBecomes(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/AirStart.ogg")
end

-- The ship shudders and the lights dim briefly as beam cannons are fired.
function Starship_TheShipShuddersAndTheLights(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Background"..math.random(1, 5)..".ogg")
  CurrentCombatSound = PlayCombatSound("Space/CannonFire"..math.random(1, 6)..".ogg", math.random(-100, 100))
end

-- You hear the sound of the engines as the ship begins to move.
function Starship_YouHearTheSoundOfThe2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/Accelerate.ogg")
end

-- The engine stops as the ship arrives at a destination.
function Starship_TheEngineStopsAsTheShip(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/Decelerate.ogg")
end

-- The thrusters of * begin to glow bright red, and the ship launches toward the sky with a roar, leaving behind a wave of heat and a trail of fire.
function Starship_TheThrustersOfBeginToGlow(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/OtherLaunching"..math.random(1, 3)..".ogg")
end

-- You hear the distinctive roar of starship engines, and look up to see a starship quickly approaching from a distance, making careful maneuvers toward * in order to *.
function Starship_YouHearTheDistinctiveRoarOf(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/OtherLanding"..math.random(1, 3)..".ogg")
end

-- You hear the microdrones working in the background as they repair the damage.
function Starship_YouHearTheMicrodronesWorkingIn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Repair"..math.random(1, 7)..".ogg")
end

-- You hear a buzzing sound from the * as repairs continue.
function Starship_YouHearABuzzingSoundFrom(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Repair"..math.random(1, 7)..".ogg")
end

-- You hear a shrill screeching sound as repair drones drag replacement components across the *
function Starship_YouHearAShrillScreechingSound(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Repair"..math.random(1, 7)..".ogg")
end

-- You hear a deafening booming sound as repairs to the ship proceed.
function Starship_YouHearADeafeningBoomingSound(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Repair"..math.random(1, 7)..".ogg")
end

-- You hear an electrical zapping sound as repairs to the ship continue.
function Starship_YouHearAnElectricalZappingSound(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Repair"..math.random(1, 7)..".ogg")
end

-- You hear several clinking sounds as the ship is repaired.
function Starship_YouHearSeveralClinkingSoundsAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Repair"..math.random(1, 7)..".ogg")
end

-- Suddenly, you hear a massive crashing and booming sound as the repair drones go to super power! They're repairing * now!
function Starship_SuddenlyYouHearAMassiveCrashing(name, line, wildcards)
  for i = 1, 7 do
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Repair"..i..".ogg")
  end
  Note("Repairing " .. wildcards[1] .. " with super power!")
end

-- There is no more room for trash in the storage compartment. *
function Starship_ThereIsNoMoreRoomFor(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/StorageFull.ogg")
end

-- Charge is too low for harvesting.
function Starship_ChargeIsTooLowForHarvesting(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/LowCharge"..math.random(1, 2)..".ogg")
end

-- There is nothing here to scan.
function Starship_ThereIsNothingHereToScan(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/NothingHere.ogg")
end

-- You hear a series of clicks from below as items are removed from the storage compartment.
function Starship_YouHearASeriesOfClicks(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/TransferStart.ogg")
end

-- The clicks coming from below abruptly stop.
function Starship_TheClicksComingFromBelowAbruptly(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/TransferEnd.ogg")
end

-- You hear a series of clicks from below as the refinery is emptied into a starship.
function Starship_YouHearASeriesOfClicks2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Transfer"..math.random(1, 3)..".ogg")
end

-- There are no * to fire.
function Starship_ThereAreNoToFire(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Warning.ogg")
end

-- Self-destruct sequence initiated! Destruction in sixty seconds.
function Starship_SelfDestructSequenceInitiatedDestructionIn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/SelfDestructStart.ogg")
end

-- The relic... EXPLODES!
function Starship_TheRelicExplodes(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/RelicExplosion.ogg")
end

-- An alert flashes on a nearby power management console for your immediate attention: "*"
function Starship_AnAlertFlashesOnANearby(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Warning.ogg")
  if (string.match(string.lower(wildcards[1]), "critical charge alert")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/LowCharge"..math.random(1, 2)..".ogg")
  end
end

-- A low hum comes to life as the shields begin recharging.
function Starship_ALowHumComesToLife(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/ShieldsRecharging.ogg")
end

-- The construction facility is powering up.
function Starship_TheConstructionFacilityIsPoweringUp(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/ConstructionFacilityPowerUp.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- A low hum starts up as the construction facility is activated.
function Starship_ALowHumStartsUpAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/ConstructionFacilityPowerUp.ogg")
end

-- The barely noticeable hum of the construction facility dies as it is deactivated.
function Starship_TheBarelyNoticeableHumOfThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/ConstructionFacilityPowerDown.ogg")
end

-- The construction facility is shutting down.
function Starship_TheConstructionFacilityIsShuttingDown(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/ConstructionFacilityPowerDown.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- The hum stops as the refinery completes its work.
function Starship_TheHumStopsAsTheRefinery(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/ConstructionFacilityPowerDown.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- A slowly rotating black rift appears in front of the ship.
function Starship_ASlowlyRotatingBlackRiftAppears(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/RiftForms.ogg")
end

-- The ship shakes as it ripples the fabric of space, entering a rift of deep, pulsing blackness.
function Starship_TheShipShakesAsItRipples(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/Rift.ogg")
end

-- The starship shudders as it enters a *
function Starship_TheStarshipShuddersAsItEnters(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/Stargate"..math.random(1, 3)..".ogg")
end

-- With a final jolt, the starship slows as it exits the *
function Starship_WithAFinalJoltTheStarship(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/StargateNotification.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- You detect a faint rumbling as the starship begins to orient toward another ship.
function Starship_YouDetectAFaintRumblingAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/RingStart.ogg")
end

-- The engines begin to vibrate mildly as the ship accelerates toward another starship.
function Starship_TheEnginesBeginToVibrateMildly(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/RingStart.ogg")
end

-- The starship rocks gently as the docking ring comes into contact with another starship.
function Starship_TheStarshipRocksGentlyAsThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/RingEnd.ogg")
end

-- You hear a satisfying click as the ship's docking ring is retracted from the docked ship's hull.
function Starship_YouHearASatisfyingClickAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/RingRemove.ogg")
end

-- You feel a faint vibration as the ship begins to launch into open space.
function Starship_YouFeelAFaintVibrationAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/RingRemove.ogg")
end

-- You hear a loud klang as robotic arms transport the ship from the garage to the *
function Starship_YouHearALoudKlangAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/LandingPad.ogg")
end

-- You hear a loud clang as robotic arms seize the ship and transport it to the *
function Starship_YouHearALoudClangAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/LandingPad.ogg")
end

-- You hear a short hum as hydraulic arms smoothly haul the ship from the garage *
function Starship_YouHearAShortHumAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/LandingPad.ogg")
end

-- You hear a short hum as hydraulic arms smoothly haul the ship from * into the garage.
function Starship_YouHearAShortHumAs2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Garage.ogg")
end

-- * is gently lifted up and smoothly hauled into the garage by a pair of hydraulic arms.
function Starship_IsGentlyLiftedUpAndSmoothly(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/GarageExt.ogg")
end

-- * is transported into *.
function Starship_IsTransportedInto(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/GarageExt.ogg")
end

-- * is smoothly hauled into the area and placed on a large, metal platform.
function Starship_IsSmoothlyHauledIntoTheArea(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/GarageExt.ogg")
end

-- * is gently lifted from its platform and smoothly hauled out of the area by a pair of hydraulic arms.
function Starship_IsGentlyLiftedFromItsPlatform(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/LandingPadExt.ogg")
end

-- * is smoothly hauled onto the (.*) and gently set down, ready for launch.
function Starship_IsSmoothlyHauledOntoTheAnd(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/LandingPadExt.ogg")
end

-- You hear a loud clang as robotic arms seize the ship and transport it to the garage.
function Starship_YouHearALoudClangAs2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Garage.ogg")
end

-- You hear a loud klang as robotic arms transport the ship from the * to the garage.
function Starship_YouHearALoudKlangAs2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Garage.ogg")
end

-- * appear*in a beam of*light!
function Starship_AppearInABeamOfLight(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Light.ogg")
end

-- * appears in the room from a bright beam of light.
function Starship_AppearsInTheRoomFromA(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Light.ogg")
end

-- A bright beam surrounds *. When it fades, * is no longer in the room.
function Starship_ABrightBeamSurroundsWhenIt(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Light.ogg")
end

-- *suddenly enveloped in a * beam of light.*
function Starship_SuddenlyEnvelopedInABeamOf(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Light.ogg")
end

-- *beam of light surrounds you. When it fades, you notice that your surroundings have changed.
function Starship_BeamOfLightSurroundsYouWhen(name, line, wildcards)
  if (string.match(wildcards[1], "A bright red")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Light.ogg")
  else
    CurrentGlobalSound = PlayGlobalSound("General/Misc/WormholeInt.ogg")
  end
end

-- * encased in a beam of electric blue light!
function Starship_EncasedInABeamOfElectric(name, line, wildcards)
  if (string.match(wildcards[1], "You are")) then
    StopSound(CurrentRoomSound)
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Light.ogg")
  else
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Light.ogg")
  end
end

-- *wormhole transport console*humming*.
function Starship_WormholeTransportConsoleHumming(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/WormHoleConsoleActive.ogg")
end

-- The pod begins to vibrate mildly as it activates its jump drive.
function Starship_ThePodBeginsToVibrateMildly(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/EscapePodWormHoleJump"..math.random(1, 2)..".ogg")
end

-- The vibration calms as the pod completes its jump, and begins to accelerate through space.
function Starship_TheVibrationCalmsAsThePod(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/EscapePodDescend.ogg")
end

-- With a sharp jolt, the pod touches down on the planet's surface. It then begins breaking apart, and you wearily climb out.
function Starship_WithASharpJoltThePod(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/EscapePodLands.ogg")
end

-- A vehicle's small computer screen. Checked from top to bottom; the first entry that fits
-- is played. (See common.lua for what each field means.)
--   hide_unless   the name of a setting: while it's 0, the message isn't shown (it's still
--                 added to the buffers). CollectingMessages has no command to switch it, so
--                 "collected" messages are always hidden.
VEHICLE_SCREEN_SOUNDS = {
  { has = "collected", hide_unless = "CollectingMessages" },  -- no sound
  { has_lower = "confirmed hit on", sound = "Ground/GrenadeExplode", combat = true },
  { has_lower = "weapons locked on", sound = "Space/LockedOnOther", combat = true },
  { has_lower = { "beginning", "repair" }, sound = "Starship/Computer/RepairStart" },
  { has_lower = "repair complete", sound = "Starship/Computer/RepairComplete" },
  { has_lower = "aborting repair", sound = "Starship/Computer/RepairAborted" },
  { has_lower = "recharging", sound = "Starship/Misc/BatteryRecharging" },
  { has = "recharged", sound = "General/Misc/Beep", versions = 5 },
  { has_lower = "charge running low", sound = "Starship/Computer/LowCharge", versions = 2 },
  { has_lower = "excavation cannot be started due to the vehicle running low on charge", sound = "Starship/Computer/LowCharge", versions = 2 },
  { has_lower = "stored minerals", sound = "Starship/computer/Display" },
  { has_lower = "storage full", sound = "Starship/Misc/StorageFull" },
  { has_lower = "storage capacity full", sound = "Starship/Misc/StorageFull" },
  { has_lower = "current charge", sound = "Starship/Computer/Display" },
  { has_lower = "items in the storage compartment", sound = "Starship/Computer/Display" },
  { has = "destroyed", sound = "Space/OtherDestroyed", versions = 8, combat = true },
  { has = "Scanning", sound = "Vehicle/Scanning" },
}

-- A small computer screen announces, "*"
-- Every announcement is added to the All and Vehicle Computer Announcements buffers and
-- plays the announcement chime; VEHICLE_SCREEN_SOUNDS may add its own sound. Then it's shown.
function Starship_ASmallComputerScreenAnnounces(name, line, wildcards)
  local text = wildcards[1]
  Execute("history_add All=Vehicle Computer Announcement: " .. text)
  Execute("history_add Vehicle Computer Announcements=" .. text)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Announce" .. math.random(1, 7) .. ".ogg")
  local entry = FindSoundEntry(VEHICLE_SCREEN_SOUNDS, text)
  if entry then
    if entry.hide_unless and ConfigTable.Settings[entry.hide_unless] == 0 then
      return
    end
    PlaySoundEntry(entry, text)
  end
  Note(text)
end

-- Equipment Damage: *%.
function Starship_EquipmentDamage(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- You hear the muted click of a power cable attaching itself to the vehicle and a low hum as power is transferred into the vehicle's battery.
function Starship_YouHearTheMutedClickOf(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/BatteryRecharging.ogg")
end

-- You hear the microdrones working in the background as they repair the damaged equipment.
function Starship_YouHearTheMicrodronesWorkingIn2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Repair"..math.random(1, 7)..".ogg")
end

-- * tap*some buttons on the * console.
function Starship_TapSomeButtonsOnTheConsole(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- * begin*inputting a sequence of commands into a wormhole transport console.
function Starship_BeginInputtingASequenceOfCommands(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- * check*the starship's record console.
function Starship_CheckTheStarshipRecordConsole(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- * check*a damage console.
function Starship_CheckADamageConsole(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- * examine*a *
function Starship_ExamineA(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- * examine*the *
function Starship_ExamineThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- * input*.
function Starship_Input(name, line, wildcards)
  if string.match(wildcards[1], "You") then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
    Note(line)
  end
end

-- * begin*tapping commands into * console.
function Starship_BeginTappingCommandsIntoConsole(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- You tap a 'MINERAL' icon on a status console.
function Starship_YouTapAMineralIconOn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/MiniKeyboard.ogg")
end

-- * shift*the throttle into *
function Starship_ShiftTheThrottleInto(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Lever"..math.random(1, 5)..".ogg")
end

-- * press* finger on the scanner next to the *.
function Starship_PressFingerOnTheScannerNext(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Scanning.ogg")
end

-- The scanner flashes a * light.
function Starship_TheScannerFlashesALight(name, line, wildcards)
  if (string.match(wildcards[1], "green")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/ScanSuccess.ogg")
  elseif (string.match(wildcards[1], "red")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/ScanFailure.ogg")
  end
end

-- Sorry, that area is restricted to * only.
function Starship_SorryThatAreaIsRestrictedTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/ScanFailure.ogg")
end

-- You are denied access to that information.
function Starship_YouAreDeniedAccessToThat(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/ScanFailure.ogg")
end

-- There * to transfer.
function Starship_ThereToTransfer(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/ScanFailure.ogg")
end

-- A small light near the hatch of * flashes *
function Starship_ASmallLightNearTheHatch(name, line, wildcards)
  if (string.match(wildcards[2], "once")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/AirlockFlashesOnce.ogg")
  elseif (string.match(wildcards[2], "twice")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/AirlockFlashesTwice.ogg")
  end
end

-- You see several lights blink in rapid succession on the navigation console, informing you that the ship is being * by *.
function Starship_YouSeeSeveralLightsBlinkIn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/SomeoneScannedYou.ogg")
  Note("This starship was " .. wildcards[1] .. " by " .. wildcards[2] .. ".")
end

-- The planetary damage of this planet is * units out of 100.0 units.
function Starship_ThePlanetaryDamageOfThisPlanet(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
  if (string.match(wildcards[1], "^0.0$")) then
    Note("No damages.")
  else
    Note("Damage: " .. wildcards[1] .. " units.")
  end
end

-- You hear a soft knocking from the starship's hull.
function Starship_YouHearASoftKnockingFrom(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/HullKnocking.ogg")
end

-- You calmly knock on the hull of *
function Starship_YouCalmlyKnockOnTheHull(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/HullKnocking.ogg")
end

-- An escape pod lands nearby.
function Starship_AnEscapePodLandsNearby(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/EscapePodLands.ogg")
end

-- A soft hum starts in the background as the launchers begin reloading.
function Starship_ASoftHumStartsInThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/RefillingBanks.ogg")
end

-- * key*a few commands into *.
function Starship_KeyAFewCommandsInto(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- * begin*inputting commands into * console.
function Starship_BeginInputtingCommandsIntoConsole(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- * examine*a sector scan.
function Starship_ExamineASectorScan(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Scan4.ogg")
end

-- The military has shut down the application process for the time being. We appologize for the inconvenience!
function Starship_TheMilitaryHasShutDownThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/ScanFailure.ogg")
end

-- You tap a few buttons, making a small screen flash with lights.
function Starship_YouTapAFewButtonsMaking(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- You can not use this drive for *
function Starship_YouCanNotUseThisDrive(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- The ship was last moving *
function Starship_TheShipWasLastMoving(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Please power up your weapons first.
function Starship_PleasePowerUpYourWeaponsFirst(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/NotInSpace.ogg")
end

-- You reach under the control board, and open a small metal panel before installing * override chip.
function Starship_YouReachUnderTheControlBoard(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Report"..math.random(1, 4)..".ogg")
end

-- * place*in-ship camera installation chip against a console.
function Starship_PlaceInShipCameraInstallationChip(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Report"..math.random(1, 4)..".ogg")
end

-- * in-ship camera installation chip slides into the console and eventually out of view.
function Starship_InShipCameraInstallationChipSlides(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Report"..math.random(1, 4)..".ogg")
end

-- Something deep within the ship's bowels explodes!
function Starship_SomethingDeepWithinTheShipBowels(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/BatteryExplosion"..math.random(1, 3)..".ogg")
end

-- There are no damages.
function Starship_ThereAreNoDamages(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Damage: *%.
function Starship_Damage(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- The storage area contains:
function Starship_TheStorageAreaContains(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- The storage hold contains:
function Starship_TheStorageHoldContains(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- A series of clicks is heard as a transfer process begins.
function Starship_ASeriesOfClicksIsHeard(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/TransferStart.ogg")
end

-- The clicks finally vanish as the transfer process completes.
function Starship_TheClicksFinallyVanishAsThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/TransferEnd.ogg")
end

-- No mined minerals could be found.
function Starship_NoMinedMineralsCouldBeFound(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- * hit*a few keys on a weapons board.
function Starship_HitAFewKeysOnA(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- The ship accelerates into hyperspace.
function Starship_TheShipAcceleratesIntoHyperspace(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/Accelerate.ogg")
end

-- The ship decelerates into real space.
function Starship_TheShipDeceleratesIntoRealSpace(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/Decelerate.ogg")
end

-- The ship suddenly shoots into realspace.
function Starship_TheShipSuddenlyShootsIntoRealspace(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/Decelerate.ogg")
end

-- There are no artifacts in the storage area.
function Starship_ThereAreNoArtifactsInThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- The following artifacts are in the storage area:
function Starship_TheFollowingArtifactsAreInThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Vehicle Bay Status:
function Starship_VehicleBayStatus(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- The * should be in space before you attempt this.
function Starship_TheShouldBeInSpaceBefore2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/NotInSpace.ogg")
end

-- The scanning console emits a series of beeps before depositing *.
function Starship_TheScanningConsoleEmitsASeries(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Scanning.ogg")
  if (string.match(wildcards[1], "Easter egg")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/EggHunt.ogg")
  end
end

-- A smooth hum starts in the background and the lift begins moving.
function Starship_ASmoothHumStartsInThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/LiftGo.ogg")
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/LiftMoving.ogg")
end

-- The hum slowly stops as the lift arrives at its destination.
function Starship_TheHumSlowlyStopsAsThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/LiftArrived.ogg")
end

-- A computer screen flickers to life, displaying a pictograph transmission from *
function Starship_AComputerScreenFlickersToLife(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/CameraFeed.ogg")
end

-- The ship moves carefully in the vastness of hyperspace.
function Starship_TheShipMovesCarefullyInThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Move/Hyperrouting.ogg")
end

-- The smell of * wafts into the room.
function Starship_TheSmellOfWaftsIntoThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Scents.ogg")
end

-- You slide a panel aside, and proceed to fit * partial vehicle replacement battery into a slot.
function Starship_YouSlideAPanelAsideAnd(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Report"..math.random(1, 4)..".ogg")
end

-- You close the panel, as * partial vehicle replacement battery locks into place with a *CLICK*.
function Starship_YouCloseThePanelAsPartial(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Report"..math.random(1, 4)..".ogg")
end

-- You are zapped by a forcefield as you try to move *.
function Starship_YouAreZappedByAForcefield(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Electricity.ogg")
end

-- * pull*the lever on * slot machine.
function Starship_PullTheLeverOnSlotMachine(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Lever"..math.random(1, 5)..".ogg")
end

-- The displays flicker and the ship's lights dim briefly as more power is diverted to the shields.
function Starship_TheDisplaysFlickerAndTheShip(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/CameraFeed.ogg")
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Background"..math.random(1, 5)..".ogg")
end

-- * the main owner of this starship. *
function Starship_TheMainOwnerOfThisStarship(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- You glance at the repair status panel.
function Starship_YouGlanceAtTheRepairStatus(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- You hear a slight hum as the ship *.
function Starship_YouHearASlightHumAs(name, line, wildcards)
  if (string.match(string.lower(wildcards[1]), "cloaks")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/CloakOn.ogg")
  elseif (string.match(string.lower(wildcards[1]), "becomes visible")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/CloakOff.ogg")
  end
end

-- The ship shakes, pouring more power into *.
function Starship_TheShipShakesPouringMorePower(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Background5.ogg")
end

-- The viewscreen is filled with brilliant white light as Relic * explodes!
function Starship_TheViewscreenIsFilledWithBrilliant(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/RelicExplosion.ogg")
end

-- Coordinates: (*)
function Starship_Coordinates(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Scan"..math.random(1, 4)..".ogg")
end

-- * tap*a few commands into *.
function Starship_TapAFewCommandsInto(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- * tap*a few buttons on *.
function Starship_TapAFewButtonsOn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
end

-- Enter security access code:
function Starship_EnterSecurityAccessCode(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Code.ogg")
end

-- The keypad beeps, allowing you to pass.
function Starship_TheKeypadBeepsAllowingYouTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/ScanSuccess.ogg")
  Note("Code accepted.")
end

-- A small panel flashes 'Access denied' when you tap some keys on the keypad.
function Starship_ASmallPanelFlashesAccessDenied(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/ScanFailure.ogg")
  Note("Code denied.")
end

-- A nearby console beeps twice in rapid succession, indicating the occurrence of a naturally occuring spacial anomaly. A spacebear has just disappeared from sensors.
function Starship_ANearbyConsoleBeepsTwiceIn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/SpacebearVanish.ogg")
end

-- Hyperscan results:
function Starship_HyperscanResults(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end

-- Invaded report:
function Starship_InvadedReport(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
end
