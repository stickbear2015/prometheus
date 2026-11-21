-- Vehicles.
-- Trigger functions for worlds/plugins/prometheus/vehicles.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- * lock*the door leading *.
function Vehicles_LockTheDoorLeading(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Lock.ogg")
end

-- * lock*the vehicle.
function Vehicles_LockTheVehicle(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Lock.ogg")
end

-- *unlock*the door to Apartment * and head*inside.
function Vehicles_UnlockTheDoorToApartmentAnd(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Lock.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/DoorOpen.ogg")
end

-- * unlock*the door leading *.
function Vehicles_UnlockTheDoorLeading(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Unlock.ogg")
end

-- * unlock*the vehicle.
function Vehicles_UnlockTheVehicle(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Unlock.ogg")
end

-- You activate the trash collectors.
function Vehicles_YouActivateTheTrashCollectors(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Activate.ogg")
end

-- A loud thud can be heard from the storage compartment as trash is deposited by the collectors.
function Vehicles_ALoudThudCanBeHeard(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/TrashThump.ogg")
end

-- The floor beneath your feet begins rumbling softly as the refinery is activated.
function Vehicles_TheFloorBeneathYourFeetBegins(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/TrashRefinery.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- * board*the * "*".
function Vehicles_BoardThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Enter.ogg")
end

-- * exit*the * "*".
function Vehicles_ExitThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Leave.ogg")
end

-- You hear a barely audible hum as the engines activate, and the floor beneath your feet begins vibrating slightly.
function Vehicles_YouHearABarelyAudibleHum(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/EngineStart.ogg")
end

-- The floor beneath your feet begins to rumble as the engines begin shutting down.
function Vehicles_TheFloorBeneathYourFeetBegins2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/EngineStop.ogg")
end

-- The hum suddenly falls silent, leaving you in complete silence.
function Vehicles_TheHumSuddenlyFallsSilentLeaving(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/EngineStop.ogg")
  StopSound(CurrentRoomSound)
end

-- The pitch of the engines * ever so slightly as the vehicle *
function Vehicles_ThePitchOfTheEnginesEver(name, line, wildcards)
  if (string.match(wildcards[1], "decreases") and string.match(wildcards[2], "stops")) then
    CurrentGlobalSound = PlayGlobalSound("Vehicle/CarStop.ogg")
  elseif (string.match(wildcards[1], "increases") and string.match(wildcards[2], "begins moving")) then
    CurrentGlobalSound = PlayGlobalSound("Vehicle/CarGo.ogg")
  end
end

-- You hear a loud clang as a chunk of minerals is deposited into the mineral area.
function Vehicles_YouHearALoudClangAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Store.ogg")
end

-- The vehicle rumbles a bit as it moves towards the vehicle hatch of *
function Vehicles_TheVehicleRumblesABitAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Start.ogg")
end

-- The vehicle comes to a stop inside the vehicle bay and the engines pitch down to an idle level. You hear several muted clangs as a set of clamps secure themselves to the body of the vehicle.
function Vehicles_TheVehicleComesToAStop(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/CarStop.ogg")
end

-- The vehicle rumbles a bit as it moves towards the vehicle hatch.
function Vehicles_TheVehicleRumblesABitAs2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Start.ogg")
end

-- The vehicle begins shaking in place as it prepares for launching.
function Vehicles_TheVehicleBeginsShakingInPlace(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Scoopers/Prelaunch.ogg")
end

-- The engines kick in and the vehicle ascends sharply as it accelerates into the atmosphere.
function Vehicles_TheEnginesKickInAndThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Scoopers/Ascending.ogg")
end

-- The engines begin rumbling slightly as the vehicle begins descending through the atmosphere.
function Vehicles_TheEnginesBeginRumblingSlightlyAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Scoopers/Descending.ogg")
end

-- The engines calm slightly and gravity returns to normal as the vehicle steadies itself.
function Vehicles_TheEnginesCalmSlightlyAndGravity(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Thrusters.ogg")
end

-- Black lightning rips through the sky in front of the vehicle as the quantum shift matrix is activated.
function Vehicles_BlackLightningRipsThroughTheSky(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/QuantumDriveStart.ogg")
end

-- A black hole opens in front of the vehicle. *
function Vehicles_ABlackHoleOpensInFront(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/QuantumDriveFinish.ogg")
end

-- * activate*the vehicle's material scoopers.
function Vehicles_ActivateTheVehicleMaterialScoopers(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Scoopers/ActivateScooper.ogg")
end

-- A loud thud can be heard as a piece of scoopable material is deposited into the storage area.
function Vehicles_ALoudThudCanBeHeard2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Scoopers/Scooped.ogg")
end

-- A sudden wind pummels the vehicle, making it spin out of control!
function Vehicles_ASuddenWindPummelsTheVehicle(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Scoopers/Wind.ogg")
end

-- Finally, the wind releases the vehicle from it's grasp.
function Vehicles_FinallyTheWindReleasesTheVehicle(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Scoopers/Wind.ogg")
end

-- Your scooper just took * percent damage.
function Vehicles_YourScooperJustTookPercentDamage(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Damaged.ogg")
end

-- The ship shakes, pouring more power to the beam.
function Vehicles_TheShipShakesPouringMorePower(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Store.ogg")
end

-- The beam returns with something in its grasp.
function Vehicles_TheBeamReturnsWithSomethingIn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Store.ogg")
end

-- Some whooshes and clangs come from below.
function Vehicles_SomeWhooshesAndClangsComeFrom(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Vehicle/Store.ogg")
end
