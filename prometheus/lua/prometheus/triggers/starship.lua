-- Starship sounds: movement, docking, systems, sensors, mining and repairs.
-- Trigger functions for worlds/plugins/prometheus/starship.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- ^\[([A-Za-z- ]+)\][,:]? ["]?(.*)["]?$
function Starship_AZa(name, line, wildcards)
  if (ConfigTable.Settings.CommpipeHarvestFilter == 1) then
    if (string.match(wildcards[1],"Commpipe")) then
      if (string.match(wildcards[2], "has been salvaged") or string.match(wildcards[2], "has been harvested") or string.match(wildcards[2], "harvested") or string.match(wildcards[2], "successfully grabbed") or string.match(wildcards[2], "Valuable material found") or string.match(wildcards[2], "No minerals detected")) then
        return
      end
    end
  end
  Note(line)
  if not tonumber(wildcards[1]) then
    if (string.len(wildcards[1]) > 1) then
      Execute("history_add All=" .. line)
      Execute("history_add "..prometheus.util.Explode(wildcards[1], "-")[1].."=" .. wildcards[2])
    end
    CurrentGlobalSound = PlayGlobalSound("General/Channels/" .. wildcards[1] .. ".ogg")
    if (string.match(wildcards[1], "OOC") and string.match(wildcards[2], "A pre-recorded message")) then
      CurrentGlobalSound = PlayGlobalSound("General/Hosts/Announcement.ogg")
    elseif (string.match(wildcards[1], "General") and string.match(wildcards[2], "UTF Communications Officer")) then
      CurrentGlobalSound = PlayGlobalSound("General/Misc/Alarm.ogg")
    elseif (string.match(string.lower(wildcards[1]), "info")) then
      if (string.match(wildcards[2], "entered the game")) then
        CurrentGlobalSound = PlayGlobalSound("General/Misc/LoggedOn.ogg")
      elseif (string.match(wildcards[2], "left the game")) then
        CurrentGlobalSound = PlayGlobalSound("General/Misc/LoggedOff.ogg")
      end
    elseif (string.match(string.lower(wildcards[1]), "flight control")) then
      if (string.match(wildcards[2], "static")) then
        CurrentGlobalSound = PlayGlobalSound("General/Comm/Static"..math.random(1, 5)..".ogg")
      elseif (string.match(string.lower(wildcards[2]), "ground on")) then
        CurrentCombatSound = PlayCombatSound("Ground/GroundTroops.ogg")
      elseif (string.match(string.lower(wildcards[2]), "enemies are forcing a landing")) then
        CurrentGlobalSound = PlayGlobalSound("General/Comm/FlightControlForcedLanding.ogg")
      elseif (string.match(wildcards[2], "Forced landing at")) then
        CurrentGlobalSound = PlayGlobalSound("General/Comm/FlightControlForcedLanding.ogg")
      elseif (string.match(wildcards[2], "Detecting") and string.match(wildcards[2], "Repeat")) then
        CurrentGlobalSound = PlayGlobalSound("General/Comm/FlightControlEnemiesEntering.ogg")
      elseif (string.match(wildcards[2], "inbound enemy")) then
        CurrentGlobalSound = PlayGlobalSound("General/Comm/FlightControlEnemiesEntering.ogg")
      elseif (string.match(wildcards[2], "retreating")) then
        CurrentGlobalSound = PlayGlobalSound("General/Comm/FlightControlEnemiesRetreating.ogg")
      elseif (string.match(wildcards[2], "destroyed")) then
        if not string.match(wildcards[2], "X-Loritan") then
          CurrentGlobalSound = PlayGlobalSound("Combat/Space/OtherDestroyed"..math.random(1, 8)..".ogg")
        end
      elseif (string.match(wildcards[1],"Commpipe")) then
        if (string.match(wildcards[2], "has been salvaged") or string.match(wildcards[2], "has been harvested") or string.match(wildcards[2], "successfully grabbed") or string.match(wildcards[2], "Valuable material found") or string.match(wildcards[2], "No minerals detected")) then
          if (ConfigTable.Settings.SalvagingMessages == 0) then
            if (string.match(wildcards[2], "prepared for future use")) then
              CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Prepared.ogg")
            else
              return
            end
          end
          if (ConfigTable.Settings.GrabbingMessages == 0) then
            return
          end
          if (ConfigTable.Settings.HarvestingMessages == 0) then
            return
          end
        elseif (string.match(wildcards[1], "detected in the sector")) then
          if (string.match(wildcards[1], "enemy starship")) then
            CurrentGlobalSound = PlayGlobalSound("Starship/Computer/EnemyDetected.ogg")
          end
          if (string.match(wildcards[1], "flying cherub")) then
            CurrentGlobalSound = PlayGlobalSound("Starship/Computer/flyingCherub.ogg")
          end
          if (string.match(wildcards[1], "artifact")) then
            CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Artifact.ogg")
          end
          if (string.match(wildcards[1], "friendly")) then
            CurrentGlobalSound = PlayGlobalSound("Starship/Computer/FriendlyShip.ogg")
          end
          if (string.match(wildcards[1], " relic")) then
            CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Relic.ogg")
          end
          if (string.match(wildcards[1], "comet")) then
            CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Comet.ogg")
          end
          if (string.match(wildcards[1], "shipwreck")) then
            CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Shipwreck.ogg")
          end
          if (string.match(wildcards[1], "planet")) then
            CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Planet.ogg")
          end
          if (string.match(wildcards[1], "spacestation")) then
            CurrentGlobalSound = PlayGlobalSound("Starship/Computer/SpaceStation.ogg")
          end
          if (string.match(string.lower(wildcards[1]), " star ")) then
            CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Star.ogg")
          end
          if (string.match(wildcards[1], "derelict starship")) then
            CurrentGlobalSound = PlayGlobalSound("Starship/Derelicts/AlienStarship.ogg")
          end
          if (string.match(wildcards[1], "asteroid")) then
            CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Asteroid.ogg")
          end
          if (string.match(wildcards[1], "debris")) then
            CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Debris.ogg")
          end
          if (string.match(wildcards[1], "spacebear")) then
            CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Spacebear.ogg")
          end
        elseif (string.match(wildcards[2], "Powering down due to lack of charge")) then
          CurrentGlobalSound = PlayGlobalSound("Starship/Computer/LowCharge"..math.random(1, 2)..".ogg")
        elseif (string.match(wildcards[2], "Shutting down due to low power conditions")) then
          CurrentGlobalSound = PlayGlobalSound("Starship/Computer/LowCharge"..math.random(1, 2)..".ogg")
        elseif (string.match(wildcards[2], "Beam locked")) then
          CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Warning.ogg")
        elseif (string.match(wildcards[2], "The beam stops abruptly")) then
          CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Warning.ogg")
        elseif (string.match(wildcards[2], "Excavation cannot continue due to the equipment being damaged")) then
          CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Warning.ogg")
        end
      end
    elseif (string.match(string.lower(wildcards[1]), "ship construction")) then
      CurrentGlobalSound = PlayGlobalSound("General/Comm/Notify.ogg")
      CurrentGlobalSound = PlayGlobalSound("General/Misc/NewsFlash.ogg")
    elseif (string.match(string.lower(wildcards[1]), "events")) then
      if (string.match(wildcards[2], "added")) then
        CurrentGlobalSound = PlayGlobalSound("General/Hosts/EventsAdded.ogg")
      end
    elseif (string.match(wildcards[1], "PA")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Comm/PA"..math.random(1, 9)..".ogg")
    end
  end
end

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

-- The computer announces, "*"
function Starship_TheComputerAnnounces(name, line, wildcards)
  Note(wildcards[1])
  Execute("history_add All=Computer Announcement: " .. wildcards[1])
  Execute("history_add Computer Announcements=" .. wildcards[1])
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Announce"..math.random(1, 7)..".ogg")
  if (string.match(wildcards[1], "detected in the sector")) then
    if (string.match(wildcards[1], "enemy starship")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Computer/EnemyDetected.ogg")
    end
    if (string.match(wildcards[1], "artifact")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Artifact.ogg")
    end
    if (string.match(wildcards[1], "friendly")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Computer/FriendlyShip.ogg")
    end
    if (string.match(wildcards[1], " relic")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Relic.ogg")
    end
    if (string.match(wildcards[1], "comet")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Comet.ogg")
    end
    if (string.match(wildcards[1], "shipwreck")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Shipwreck.ogg")
    end
    if (string.match(wildcards[1], "planet")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Planet.ogg")
    end
    if (string.match(wildcards[1], "spacestation")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Computer/SpaceStation.ogg")
    end
    if (string.match(string.lower(wildcards[1]), " star ")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Star.ogg")
    end
    if (string.match(wildcards[1], "derelict starship")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Derelicts/AlienStarship.ogg")
    end
    if (string.match(wildcards[1], "asteroid")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Asteroid.ogg")
    end
    if (string.match(wildcards[1], "debris")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Debris.ogg")
    end
    if (string.match(wildcards[1], "spacebear")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Spacebear.ogg")
    end
  elseif (string.match(wildcards[1], "generators have completed their charging cycle")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  elseif (string.match(wildcards[1], "Valuable material found")) then
    if (ConfigTable.Settings.GrabbingMessages == 0) then
      return
    end
  elseif (string.match(wildcards[1], "successfully grabbed")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Salvage"..math.random(1, 3)..".ogg")
    if (ConfigTable.Settings.GrabbingMessages == 0) then
      return
    end
  elseif (string.match(wildcards[1], "Beam locked")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Warning.ogg")
  elseif (string.match(wildcards[1], "debris cloud")) then
    if (string.match(wildcards[1], "partially salvaged") or string.match(wildcards[1], "completely salvaged")) then
      CurrentGlobalSound = PlayGlobalSound("Vehicle/Store.ogg")
    end
  elseif (string.match(wildcards[1], "has been salvaged")) then
    if (ConfigTable.Settings.SalvagingMessages == 0) then
      if (string.match(wildcards[1], "and prepared for future use")) then
        CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Prepared.ogg")
      else
        return
      end
    end
  elseif (string.match(wildcards[1], "A present disruption field prevents safe travel out of the sector")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/NAVI_Interrupted.ogg")
  elseif (string.match(wildcards[1], "This weapon system is disabled")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
  elseif (string.match(wildcards[1], "Artifacts retrieved")) then
    if not string.match(wildcards[1], "nothing") then
      CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Salvage"..math.random(1, 3)..".ogg")
    end
  elseif (string.match(wildcards[1], "Target has moved from the locked coordinates") or string.match(wildcards[1], "^Miss.$") or string.match(wildcards[1], "Target moved") or string.match(wildcards[1], "Firing incomplete due to target moving")) then
    CurrentCombatSound = PlayCombatSound("Space/LostLock.ogg")
  elseif (string.match(wildcards[1], "There is no target at the locked coordinates") or string.match(wildcards[1], "Firing aborted")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
  elseif (string.match(wildcards[1], "This ship transmits")) then
    CurrentGlobalSound = PlayGlobalSound("General/Channels/Sector.ogg")
  elseif (string.match(wildcards[1], "This starship is not equipped with the landing equipment needed to land on asteroids")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/LandingImpossible.ogg")
  elseif (string.match(string.lower(wildcards[1]), "that component is damaged beyond repair")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Warning.ogg")
  elseif (string.match(string.lower(wildcards[1]), "recharging")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/BatteryRecharging.ogg")
  elseif (string.match(string.lower(wildcards[1]), "recharge complete")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  elseif (string.match(wildcards[1], "deployed for repair of")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/RepairStart.ogg")
  elseif (string.match(wildcards[1], "completed repair of")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/RepairComplete.ogg")
  elseif (string.match(wildcards[1], "Current repair aborted")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/RepairAborted.ogg")
  elseif (string.match(wildcards[1], "banks empty")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Warning.ogg")
  elseif (string.match(wildcards[1], "WARNING")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Warning.ogg")
  elseif (string.match(wildcards[1], "cleared the solar storm")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  elseif (string.match(wildcards[1], "recharged")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  elseif (string.match(wildcards[1], "Autopilot engaged")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/Activate.ogg")
  elseif (string.match(wildcards[1], "Autopilot disengaged")) then
    CurrentGlobalSound = PlayGlobalSound("General/Devices/Deactivate.ogg")
  elseif (string.match(string.lower(wildcards[1]), "deploying asteroid anchor complete")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  elseif (string.match(string.lower(wildcards[1]), "damage taken from an explosion on the surface")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Harvesting/EquipmentDamaged.ogg")
  elseif (string.match(string.lower(wildcards[1]), "no minerals detected")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Harvesting/NoMinerals.ogg")
  elseif (string.match(string.lower(wildcards[1]), "is not equipped for asteroid landing")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/LandingImpossible.ogg")
  elseif (string.match(string.lower(wildcards[1]), "landing impossible when")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/LandingImpossible.ogg")
  elseif (string.match(string.lower(wildcards[1]), "charge levels reaching critical")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/LowCharge"..math.random(1, 2)..".ogg")
  elseif (string.match(string.lower(wildcards[1]), "storage full") or string.match(string.lower(wildcards[1]), "lack of storage space")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/StorageFull.ogg")
  elseif (string.match(wildcards[1], "Mission access code") and string.match(string.lower(wildcards[1]), "accepted")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/PiercingTone.ogg")
  elseif (string.match(wildcards[1], "Mission completed")) then
    CurrentGlobalSound = PlayGlobalSound("Music/"..math.random(1, 63)..".ogg")
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Congratulations.ogg")
  elseif (string.match(wildcards[1], "Not enough shells left to fire")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Warning.ogg")
  elseif (string.match(string.lower(wildcards[1]), "cannot refine all the material in the storage compartment")) then
    CurrentGlobalSound = PlayGlobalSound("Vehicle/RefineryFull.ogg")
  elseif (string.match(string.lower(wildcards[1]), "initiating asteroid haul to")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Keyboard"..math.random(1, 7)..".ogg")
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/HaulAsteroid"..math.random(1, 2)..".ogg")
  elseif (string.match(string.lower(wildcards[1]), "on shipwreck")) then
    CurrentGlobalSound = PlayGlobalSound("General/Shipwrecks/BeamLockedOn.ogg")
  elseif (string.match(string.lower(wildcards[1]), "self-destruct sequence initiated")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/SelfDestructStart.ogg")
  elseif (string.match(wildcards[1], "^Sixty.$")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/SelfDestructSixty.ogg")
  elseif (string.match(wildcards[1], "^Thirty.$")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/SelfDestructThirty.ogg")
  elseif (string.match(wildcards[1], "^Ten.$")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/SelfDestructTen.ogg")
  elseif (string.match(wildcards[1], "^Five.$")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/SelfDestructFive.ogg")
  elseif (string.match(wildcards[1], "^Four.$")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/SelfDestructFour.ogg")
  elseif (string.match(wildcards[1], "^Three.$")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/SelfDestructThree.ogg")
  elseif (string.match(wildcards[1], "^Two.$")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/SelfDestructTwo.ogg")
  elseif (string.match(wildcards[1], "^One.$")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/SelfDestructOne.ogg")
  elseif (string.match(string.lower(wildcards[1]), "beginning ground dock")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/DockingBayDoorOpen.ogg")
  elseif (string.match(string.lower(wildcards[1]), "harvesting aborted") and string.match(string.lower(wildcards[1]), "damaged")) then
    CurrentGlobalSound = PlayGlobalSound("General/Comets/Explosion.ogg")
  elseif (string.match(string.lower(wildcards[1]), "harvested")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Salvage"..math.random(1, 3)..".ogg")
    if (ConfigTable.Settings.HarvestingMessages == 0) then
      return
    end
  elseif (string.match(string.lower(wildcards[1]), "spacepowerup mode engaged")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/SpacePowerStartUp.ogg")
  elseif (string.match(string.lower(wildcards[1]), "powering down due to lack of charge")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/LowCharge"..math.random(1, 2)..".ogg")
  elseif (string.match(string.lower(wildcards[1]), "charge running critical")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/LowCharge"..math.random(1, 2)..".ogg")
  elseif (string.match(string.lower(wildcards[1]), "hit on")) then
    CurrentCombatSound = PlayCombatSound("Space/OtherHit"..math.random(1, 4)..".ogg")
  elseif (string.match(string.lower(wildcards[1]), "Weapon fire blocked by shields")) then
    CurrentCombatSound = PlayCombatSound("Space/FireReflected.ogg")
  elseif (string.match(string.lower(wildcards[1]), "grenade firing complete")) then
    CurrentCombatSound = PlayCombatSound("Ground/GrenadeExplode.ogg")
  elseif (string.match(string.lower(wildcards[1]), "computer piping")) then
    if (string.match(wildcards[1], "enabled")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Computer/PipeOn.ogg")
    elseif (string.match(wildcards[1], "disabled")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Computer/PipeOff.ogg")
    end
  elseif (string.match(wildcards[1], "Locked onto")) then
    CurrentCombatSound = PlayCombatSound("Space/LockedOnOther.ogg")
  elseif (string.match(wildcards[1], "Target out of") and string.match(wildcards[1], "range")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
  elseif (string.match(wildcards[1], "Detected an attempt to launch the ship while drunk")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
  elseif (string.match(wildcards[1], "Firmware upgrade complete")) then
    CurrentGlobalSound = PlayGlobalSound("Combat/Space/ArmorPiercingChipDone.ogg")
  elseif (string.match(wildcards[1], "Scanning")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Scanning.ogg")
  elseif (string.match(wildcards[1], "collided with")) then
    CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg")
  elseif (string.match(wildcards[1], "Gathering data")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Scanning.ogg")
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

-- The computer reports that *
function Starship_TheComputerReportsThat(name, line, wildcards)
  Execute("history_add All=Computer Reports: " .. wildcards[1])
  Execute("history_add Computer Reports=" .. wildcards[1])
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Report"..math.random(1, 4)..".ogg")
  if (string.match(wildcards[1], "completed repair of")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/RepairComplete.ogg")
  elseif (string.match(wildcards[1], "there is no debris")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/NoDebris.ogg")
  elseif (string.match(wildcards[1], "starship probe")) then
    if (string.match(wildcards[1], "destroyed by")) then
      CurrentGlobalSound = PlayGlobalSound("Combat/Space/OtherDestroyed"..math.random(1, 8)..".ogg")
    elseif (string.match(wildcards[1], "hacked into")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Derelicts/Hacked.ogg", math.random(-100, 100))
    elseif (string.match(wildcards[1], "Attempting to retreat")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Derelicts/DestructionTriggered.ogg")
    elseif (string.match(wildcards[1], "deployed")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Derelicts/Probe"..math.random(1, 3)..".ogg")
    elseif (string.match(wildcards[1], "discovered an artifact")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Artifact.ogg", math.random(-100, 100))
    elseif (string.match(wildcards[1], "returned to the ship")) then
      CurrentGlobalSound = PlayGlobalSound("Starship/Derelicts/ProbeReturn.ogg")
    end
  elseif (string.match(wildcards[1], "is 1 unit away")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/OneUnitAway.ogg")
  elseif (string.match(wildcards[1], "destroyed")) then
    if (string.match(wildcards[1], "X-Loritan")) then
      CurrentCombatSound = PlayCombatSound("Space/OtherDestroyed"..math.random(1, 8)..".ogg")
    else
      CurrentGlobalSound = PlayGlobalSound("Combat/Space/OtherDestroyed"..math.random(1, 8)..".ogg")
    end
  elseif (string.match(wildcards[1], "no space for the debris")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/StorageFull.ogg")
  elseif (string.match(wildcards[1], "Easter egg")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/EggItem.ogg")
  end
  Note(wildcards[1])
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

-- A small computer screen announces, "*"
function Starship_ASmallComputerScreenAnnounces(name, line, wildcards)
  Execute("history_add All=Vehicle Computer Announcement: " .. wildcards[1])
  Execute("history_add Vehicle Computer Announcements=" .. wildcards[1])
  CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Announce"..math.random(1, 7)..".ogg")
  if (string.match(wildcards[1], "collected")) then
    if (ConfigTable.Settings.CollectingMessages == 0) then
      return
    end
  elseif (string.match(string.lower(wildcards[1]), "confirmed hit on")) then
    CurrentCombatSound = PlayCombatSound("Ground/GrenadeExplode.ogg")
  elseif (string.match(string.lower(wildcards[1]), "weapons locked on")) then
    CurrentCombatSound = PlayCombatSound("Space/LockedOnOther.ogg")
  elseif (string.match(string.lower(wildcards[1]), "beginning") and string.match(string.lower(wildcards[1]), "repair")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/RepairStart.ogg")
  elseif (string.match(string.lower(wildcards[1]), "repair complete")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/RepairComplete.ogg")
  elseif (string.match(string.lower(wildcards[1]), "aborting repair")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/RepairAborted.ogg")
  elseif (string.match(string.lower(wildcards[1]), "recharging")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/BatteryRecharging.ogg")
  elseif (string.match(wildcards[1], "recharged")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  elseif (string.match(string.lower(wildcards[1]), "charge running low")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/LowCharge"..math.random(1, 2)..".ogg")
  elseif (string.match(string.lower(wildcards[1]), "Excavation cannot be started due to the vehicle running low on charge")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/LowCharge"..math.random(1, 2)..".ogg")
  elseif (string.match(string.lower(wildcards[1]), "stored minerals")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/computer/Display.ogg")
  elseif (string.match(string.lower(wildcards[1]), "storage full")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/StorageFull.ogg")
  elseif (string.match(string.lower(wildcards[1]), "storage capacity full")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/StorageFull.ogg")
  elseif (string.match(string.lower(wildcards[1]), "current charge")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
  elseif (string.match(string.lower(wildcards[1]), "items in the storage compartment")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Computer/Display.ogg")
  elseif (string.match(wildcards[1], "destroyed")) then
    CurrentCombatSound = PlayCombatSound("Space/OtherDestroyed"..math.random(1, 8)..".ogg")
  elseif (string.match(wildcards[1], "Scanning")) then
    CurrentGlobalSound = PlayGlobalSound("Vehicle/Scanning.ogg")
  end
  Note(wildcards[1])
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
