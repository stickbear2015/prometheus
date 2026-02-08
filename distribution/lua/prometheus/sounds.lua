function OnOOBmsg (name, line, wildcards)

-- Ground combat sounds.
if line == "#$#soundpack combat | ground | sniper | draw" then
CurrentGlobalSound = PlayGlobalSound("Combat/Ground/DrawSniper.ogg")
CurrentGlobalSound = PlayGlobalSound("Combat/Ground/Wield"..math.random(1, 5)..".ogg")
elseif line == "#$#soundpack combat | ground | hunting | draw" then
CurrentGlobalSound = PlayGlobalSound("Combat/Ground/DrawRifle.ogg")
CurrentGlobalSound = PlayGlobalSound("Combat/Ground/Wield"..math.random(1, 5)..".ogg")
elseif line == "#$#soundpack combat | ground | rifle | draw" then
CurrentGlobalSound = PlayGlobalSound("Combat/Ground/DrawRifle.ogg")
CurrentGlobalSound = PlayGlobalSound("Combat/Ground/Wield"..math.random(1, 5)..".ogg")
elseif line == "#$#soundpack combat | ground | shotgun | draw" then
CurrentGlobalSound = PlayGlobalSound("Combat/Ground/DrawShotgun.ogg")
CurrentGlobalSound = PlayGlobalSound("Combat/Ground/Wield"..math.random(1, 5)..".ogg")
elseif line == "#$#soundpack combat | ground | pistol | draw" then
CurrentGlobalSound = PlayGlobalSound("Combat/Ground/DrawPistol.ogg")
CurrentGlobalSound = PlayGlobalSound("Combat/Ground/Wield"..math.random(1, 5)..".ogg")

-- Skill improvement related sounds.
elseif (string.match(line, "skills") and string.match(line, "improve")) then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SkillGain.ogg")

-- Medkit sounds.
elseif line == "#$#soundpack medical | medkit | discard" then
CurrentGlobalSound = PlayGlobalSound("general/devices/medkitDiscard.ogg")
elseif line == "#$#soundpack medical | medkit | end" then
CurrentGlobalSound = PlayGlobalSound("general/devices/medkitEnd.ogg")
elseif line == "#$#soundpack medical | medkit | begin" then
CurrentGlobalSound = PlayGlobalSound("general/devices/medkitStart.ogg")

-- Weapon holster sounds.
elseif line == "#$#soundpack combat | ground | sniper | holster" then
CurrentCombatSound = PlayCombatSound("Ground/Unwield.ogg")
CurrentGlobalSound = PlayGlobalSound("Combat/Ground/Holster.ogg")
elseif line == "#$#soundpack combat | ground | hunting | holster" then
CurrentCombatSound = PlayCombatSound("Ground/Unwield.ogg")
CurrentGlobalSound = PlayGlobalSound("Combat/Ground/Holster.ogg")
elseif line == "#$#soundpack combat | ground | rifle | holster" then
CurrentCombatSound = PlayCombatSound("Ground/Unwield.ogg")
CurrentGlobalSound = PlayGlobalSound("Combat/Ground/Holster.ogg")
elseif line == "#$#soundpack combat | ground | shotgun | holster" then
CurrentCombatSound = PlayCombatSound("Ground/Unwield.ogg")
CurrentGlobalSound = PlayGlobalSound("Combat/Ground/Holster.ogg")
elseif line == "#$#soundpack combat | ground | pistol | holster" then
CurrentCombatSound = PlayCombatSound("Ground/Unwield.ogg")
CurrentGlobalSound = PlayGlobalSound("Combat/Ground/Holster.ogg")

-- Armor sounds.
elseif line == "#$#soundpack combat | ground | defense | armorOn" then
CurrentCombatSound = PlayCombatSound("Ground/ArmorEnabled.ogg")
elseif line == "#$#soundpack combat | ground | defense | armorOff" then
CurrentCombatSound = PlayCombatSound("Ground/ArmorDisabled.ogg")

-- Weapon fire and weapon hit sounds.
elseif line == "#$#soundpack combat | ground | weapons | fire" then
elseif line == "#$#soundpack combat | ground | weapons | hit" then

-- Room ambience, (starships unPowered).
elseif line == "#$#soundpack ambiance | starship | unpowered | bridge" then
StopSound(CurrentRoomSound)
elseif line == "#$#soundpack ambiance | starship | unpowered | control" then
StopSound(CurrentRoomSound)
elseif line == "#$#soundpack ambiance | starship | unpowered | airlock" then
StopSound(CurrentRoomSound)
elseif line == "#$#soundpack ambiance | starship | unpowered | misc" then
StopSound(CurrentRoomSound)
elseif line == "#$#soundpack ambiance | starship | unpowered | wr" then
StopSound(CurrentRoomSound)
elseif line == "#$#soundpack ambiance | starship | unpowered | docking" then
StopSound(CurrentRoomSound)
elseif line == "#$#soundpack ambiance | starship | unpowered | storage" then
StopSound(CurrentRoomSound)
elseif line == "#$#soundpack ambiance | starship | unpowered | vehicle" then
StopSound(CurrentRoomSound)
elseif line == "#$#soundpack ambiance | starship | unpowered | medical" then
StopSound(CurrentRoomSound)
elseif line == "#$#soundpack ambiance | starship | unpowered | engineering" then
StopSound(CurrentRoomSound)
elseif line == "#$#soundpack ambiance | starship | unpowered | corridor" then
StopSound(CurrentRoomSound)
elseif line == "#$#soundpack ambiance | starship | unpowered | stateroom" then
StopSound(CurrentRoomSound)

-- Room ambiences, (starships powered).
elseif line == "#$#soundpack ambiance | starship | powered | bridge" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Starship/control.ogg")
elseif line == "#$#soundpack ambiance | starship | powered | control" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Starship/control.ogg")
elseif line == "#$#soundpack ambiance | starship | powered | misc" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Starship/misc.ogg")
elseif line == "#$#soundpack ambiance | starship | powered | wr" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Starship/wr.ogg")
elseif line == "#$#soundpack ambiance | starship | powered | docking" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Starship/docking.ogg")
elseif line == "#$#soundpack ambiance | starship | powered | storage" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Starship/storage.ogg")
elseif line == "#$#soundpack ambiance | starship | powered | vehicle" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Starship/vehicle.ogg")
elseif line == "#$#soundpack ambiance | starship | powered | airlock" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Starship/airlock.ogg")
elseif line == "#$#soundpack ambiance | starship | powered | medical" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Starship/medical.ogg")
elseif line == "#$#soundpack ambiance | starship | powered | engineering" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Starship/engineering.ogg")
elseif line == "#$#soundpack ambiance | starship | powered | corridor" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Starship/corridor.ogg")
elseif line == "#$#soundpack ambiance | starship | powered | stateroom" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Starship/stateroom.ogg")

-- Inside rooms.
elseif line == "#$#soundpack ambiance | planet | indoors | garage" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Misc/Garage.ogg")
elseif line == "#$#soundpack ambiance | planet | indoors | houseroom" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Planet/MiscIn.ogg")
elseif line == "#$#soundpack ambiance | planet | indoors | kitchen" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Planet/MiscIn.ogg")
elseif line == "#$#soundpack ambiance | planet | indoors | misc" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Planet/MiscIn.ogg")

-- outside rooms.
elseif line == "#$#soundpack ambiance | planet | outside | houseroom" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Misc/Misc.ogg")
elseif line == "#$#soundpack ambiance | misc | outside | asteroid" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Misc/Asteroid.ogg")
elseif line == "#$#soundpack ambiance | planet | outside | landing" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Planet/Landing.ogg")
elseif line == "#$#soundpack ambiance | planet | outside | misc" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Planet/MiscOut.ogg")
elseif line == "#$#soundpack ambiance | planet | outside | shop" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Planet/MiscOut.ogg")
elseif line == "#$#soundpack ambiance | planet | outside | garage" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Misc/Garage.ogg")
elseif line == "#$#soundpack ambiance | spacestation | outside | landing" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Spacestation/Landing.ogg")
elseif line == "#$#soundpack ambiance | spacestation | outside | misc" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Spacestation/Misc.ogg")
elseif line == "#$#soundpack ambiance | spacestation | outside | shop" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Spacestation/Misc.ogg")
elseif line == "#$#soundpack ambiance | spacestation | outside | garage" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Misc/Garage.ogg")
elseif line == "#$#soundpack ambiance | misc | outside | space" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Misc/Space.ogg")
elseif line == "#$#soundpack ambiance | misc | outside | landing" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Spacestation/Landing.ogg")
elseif line == "#$#soundpack ambiance | misc | outside | misc" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Misc/Relic.ogg")
elseif line == "#$#soundpack ambiance | misc | outside | relic" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Misc/Relic.ogg")
elseif line == "#$#soundpack ambiance | planet | outside | medical" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Misc/Medical.ogg")
elseif line == "#$#soundpack ambiance | planet | outside | miningTunnel" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Misc/Cave.ogg")
elseif line == "#$#soundpack ambiance | planet | outside | campsite" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Misc/Misc.ogg")
elseif line == "#$#soundpack ambiance | misc | outside | rescuePod" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Misc/RescuePod.ogg")
elseif line == "#$#soundpack ambiance | planet | outside | lake" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Misc/Lake.ogg")
elseif line == "#$#soundpack ambiance | planet | outside | river" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Misc/River.ogg")
elseif line == "#$#soundpack ambiance | spacestation | outside | medical" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Misc/Medical.ogg")
elseif line == "#$#soundpack ambiance | planet | outside | ocean" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Misc/Ocean.ogg")
elseif line == "#$#soundpack ambiance | spacestation | outside | ocean" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Misc/Ocean.ogg")

-- Step sounds.
elseif line == "#$#soundpack footstep | starship | indoors | none" then
CurrentGlobalSound = PlayGlobalSound("Footsteps/Starship"..math.random(1, 8)..".ogg")
elseif line == "#$#soundpack footstep | planet | outside | none" then
CurrentGlobalSound = PlayGlobalSound("Footsteps/Planet"..math.random(1, 8)..".ogg")
elseif line == "#$#soundpack footstep | spacestation | outside | none" then
CurrentGlobalSound = PlayGlobalSound("Footsteps/SpaceStation"..math.random(1, 8)..".ogg")
elseif line == "#$#soundpack footstep | planet | indoors | none" then
CurrentGlobalSound = PlayGlobalSound("Footsteps/Room"..math.random(1, 4)..".ogg")

-- Doors and gates.
elseif line == "#$#soundpack door | planet | swing | open" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorOpen.ogg")
elseif line == "#$#soundpack door | planet | swing | close" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorClose.ogg")
elseif line == "#$#soundpack door | planet | Glide | open" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/DoorOpen.ogg")
elseif line == "#$#soundpack door | planet | Glide | close" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/DoorClose.ogg")
elseif line == "#$#soundpack door | spacestation | swing | open" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorOpen.ogg")
elseif line == "#$#soundpack door | spacestation | swing | close" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorClose.ogg")

-- prison door, (needs something better).
elseif line == "#$#soundpack door | spacestation | firmly slide | open" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorOpen.ogg")
elseif line == "#$#soundpack door | spacestation | firmly slide | close" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorClose.ogg")

elseif line == "#$#soundpack door | planet | roll | open" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/DoorRollingOpen.ogg")
elseif line == "#$#soundpack door | planet | roll | close" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/DoorRollingClose.ogg")
elseif line == "#$#soundpack door | planet | slide | open" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorOpen.ogg")
elseif line == "#$#soundpack door | planet | slide | close" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorClose.ogg")
elseif line == "#$#soundpack door | planet | slowly lumber | open" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorOpen.ogg")
elseif line == "#$#soundpack door | planet | slowly lumber | close" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorClose.ogg")
elseif line == "#$#soundpack door | planet | revolve | open" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorOpen.ogg")
elseif line == "#$#soundpack door | planet | revolve | close" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorClose.ogg")
elseif line == "#$#soundpack door | planet | lift | open" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorOpen.ogg")
elseif line == "#$#soundpack door | planet | lower | close" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorClose.ogg")
elseif line == "#$#soundpack door | planet | flutter | open" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorOpen.ogg")
elseif line == "#$#soundpack door | planet | flutter | close" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorClose.ogg")
elseif line == "#$#soundpack door | planet | squelch | open" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorOpen.ogg")
elseif line == "#$#soundpack door | planet | squelch | close" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/SwingDoorClose.ogg")
elseif line == "#$#soundpack door | starship | slide | close" then
CurrentGlobalSound = PlayGlobalSound("Starship/Misc/DoorSlideClose.ogg")
elseif line == "#$#soundpack door | starship | slide | open" then
 CurrentGlobalSound = PlayGlobalSound("Starship/Misc/DoorSlideOpen.ogg")
elseif line == "#$#soundpack door | house | swing | open" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/DoorOpen.ogg")
elseif line == "#$#soundpack door | house | swing | close" then
CurrentGlobalSound = PlayGlobalSound("General/Misc/DoorClose.ogg")

-- Starship misc sounds.
elseif line == "#$#soundpack misc | starship | power | poweron" then
CurrentGlobalSound = PlayGlobalSound("Starship/Misc/PowerOn.ogg")
elseif line == "#$#soundpack misc | starship | power | poweroff" then
CurrentGlobalSound = PlayGlobalSound("Starship/Misc/PowerOff.ogg")

-- Starship combat sounds.
elseif line == "#$#soundpack combat | starship | defense | shieldsOn" then
CurrentGlobalSound = PlayGlobalSound("Combat/Space/Shields.ogg")
elseif line == "#$#soundpack combat | starship | defense | shieldsOff" then
CurrentGlobalSound = PlayGlobalSound("Starship/Misc/PanelsOff.ogg")
elseif line == "#$#soundpack combat | starship | defense | reflect" then
CurrentCombatSound = PlayCombatSound("Space/Reflectors"..math.random(1, 3)..".ogg")
elseif line == "#$#soundpack combat | starship | general | shrapnel" then
CurrentCombatSound = PlayCombatSound("Space/Reflectors"..math.random(1, 3)..".ogg")

-- starship weapon fire.
elseif line == "#$#soundpack combat | starship | weapons | shells" then
CurrentCombatSound = PlayCombatSound("Space/ArmorPiercingShells"..math.random(1, 3)..".ogg", math.random(-100, 100))
elseif line == "#$#soundpack combat | starship | weapons | cannons" then
CurrentCombatSound = PlayCombatSound("Space/CannonFire"..math.random(1, 6)..".ogg", math.random(-100, 100))
elseif line == "#$#soundpack combat | starship | weapons | torps" then
CurrentCombatSound = PlayCombatSound("Space/Torpedoes"..math.random(1, 3)..".ogg", math.random(-100, 100))
elseif line == "#$#soundpack combat | starship | weapons | missiles" then
CurrentCombatSound = PlayCombatSound("Space/YouMissile"..math.random(1, 3)..".ogg", math.random(-100, 100))
elseif line == "#$#soundpack combat | starship | weapons | lasers" then
CurrentCombatSound = PlayCombatSound("Space/LaserFire"..math.random(1, 4)..".ogg", math.random(-100, 100))

-- Vehicle ambiences, (unPowered).
elseif line == "#$#soundpack ambiance | vehicle | unpowered | mining" then
StopSound(CurrentRoomSound)
elseif line == "#$#soundpack ambiance | vehicle | unpowered | trash" then
StopSound(CurrentRoomSound)
elseif line == "#$#soundpack misc | vehicle | mining | poweroff" then
StopSound(CurrentRoomSound)
elseif line == "#$#soundpack misc | vehicle | trash | poweroff" then
StopSound(CurrentRoomSound)
elseif line == "#$#soundpack misc | vehicle | airspace | poweroff" then
StopSound(CurrentRoomSound)
elseif line == "#$#soundpack misc | vehicle | combat | poweroff" then
StopSound(CurrentRoomSound)
elseif line == "#$#soundpack misc | vehicle | transport | poweroff" then
StopSound(CurrentRoomSound)

-- Vehicle ambiences, (powered).
elseif line == "#$#soundpack ambiance | vehicle | powered | trash" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Vehicle/Trash.ogg")
elseif line == "#$#soundpack ambiance | vehicle | powered | mining" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Vehicle/Mining.ogg")
elseif line == "#$#soundpack misc | vehicle | mining | poweron" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Vehicle/Mining.ogg")
elseif line == "#$#soundpack misc | vehicle | trash | poweron" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Vehicle/Trash.ogg")
elseif line == "#$#soundpack misc | vehicle | airspace | poweron" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Vehicle/Airspace.ogg")
elseif line == "#$#soundpack misc | vehicle | combat | poweron" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Vehicle/Combat.ogg")
elseif line == "#$#soundpack misc | vehicle | transport | poweron" then
StopSound(CurrentRoomSound)
CurrentRoomSound = PlayRoomSound("Vehicle/Transport.ogg")

-- Misc vehicle sounds.
-- Putting nothing here for now, until vehicle return behavior is more consistant, so as to not break the other vehicle sounds.
elseif line == "#$#soundpack misc | vehicle | mining | return_begin" then
elseif line == "#$#soundpack misc | vehicle | mining | return_complete" then

else
-- Trigger line is unknown. 
-- Display it for debugging by uncommenting the next line,
-- or leave it commented for it to be ignored.
-- Note("Trigger line was: " .. line)
end
end