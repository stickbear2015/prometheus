-- Space and ground combat.
-- Trigger functions for worlds/plugins/prometheus/combat.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- ^An (X\-Loritan .+|alien creature) (kicks|punches) (you|.+) in (.+)\.$
function Combat_AnLoritanAlienCreatureKicksPunches(name, line, wildcards)
  if (string.match(wildcards[2], "kicks")) then
    CurrentGlobalSound = PlayGlobalSound("Combat/Ground/Fight/Neuter/"..math.random(1, 20)..".ogg")
    CurrentGlobalSound = PlayGlobalSound("Socials/Kick"..math.random(1, 9)..".ogg")
  elseif (string.match(wildcards[2], "punches")) then
    CurrentGlobalSound = PlayGlobalSound("Combat/Ground/Fight/Neuter/"..math.random(1, 20)..".ogg")
    CurrentGlobalSound = PlayGlobalSound("Socials/Punch"..math.random(1, 10)..".ogg")
  end
end

-- X-Loritan * has begun to generate a field of unrecorded type.
function Combat_LoritanHasBegunToGenerateA(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/Inbound.ogg")
end

-- * has begun a power buildup of some kind.
function Combat_HasBegunAPowerBuildupOf(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/PowerBuildUp"..math.random(1, 2)..".ogg")
end

-- You take * in your * hand.
function Combat_YouTakeInYourHand(name, line, wildcards)
  if (string.match(wildcards[1], "laser")) then
    CurrentCombatSound = PlayCombatSound("Ground/Wield"..math.random(1, 5)..".ogg")
  end
end

-- You feel a slight vibration from the ship as it strengthens the shields around the ship.
function Combat_YouFeelASlightVibrationFrom(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/Reflectors"..math.random(1, 3)..".ogg")
end

-- The ship lurches abruptly as super-heated shrapnel penetrates the hull.
function Combat_TheShipLurchesAbruptlyAsSuper(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg", math.random(-100, 100))
  CurrentCombatSound = PlayCombatSound("Space/Reflectors"..math.random(1, 3)..".ogg")
end

-- A low whine emanates from the shields as they successfully repel incoming shrapnel.
function Combat_ALowWhineEmanatesFromThe(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg", math.random(-100, 100))
  CurrentCombatSound = PlayCombatSound("Space/Reflectors"..math.random(1, 3)..".ogg")
end

-- The plates around the hull orient themselves, deflecting the solar mass.
function Combat_ThePlatesAroundTheHullOrient(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/Reflectors"..math.random(1, 3)..".ogg")
end

-- The starship shakes slightly as rebounded weapons fire impacts the hull.
function Combat_TheStarshipShakesSlightlyAsRebounded(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/Reflectors"..math.random(1, 3)..".ogg")
end

-- The ship rocks slightly as planetary lasers impact the hull from *
function Combat_TheShipRocksSlightlyAsPlanetary(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg", math.random(-100, 100))
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg", math.random(-100, 100))
  CurrentCombatSound = PlayCombatSound("Space/Reflectors"..math.random(1, 3)..".ogg", math.random(-100, 100))
end

-- The defense shields strengthen for a moment to block weapon fire.
function Combat_TheDefenseShieldsStrengthenForA(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/FireReflected.ogg")
end

-- The ship shakes violently as a powerful laser beam is reflected back at it!
function Combat_TheShipShakesViolentlyAsA(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/FireReflected.ogg")
end

-- This starship has been hit by *.
function Combat_ThisStarshipHasBeenHitBy(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg", math.random(-100, 100))
end

-- The ship shakes as if hit by something!
function Combat_TheShipShakesAsIfHit(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg", math.random(-100, 100))
end

-- The ship shakes violently as a projectile comes in contact with it and explodes!
function Combat_TheShipShakesViolentlyAsA2(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg", math.random(-100, 100))
end

-- The starship is hit by a massive energy beam!
function Combat_TheStarshipIsHitByA(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg", math.random(-100, 100))
end

-- The ship shudders as it begins to explode. You are thrown into the wall with force you could never believe possible, and then you find yourself somewhere else.
function Combat_TheShipShuddersAsItBegins(name, line, wildcards)
  for i = 1, 3 do
    CurrentCombatSound = PlayCombatSound("Space/YouDestroyed"..i..".ogg")
  end
end

-- The reflection plates around the ship orient themselves, successfully throwing the beam away.
function Combat_TheReflectionPlatesAroundTheShip(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/Deflect.ogg")
end

-- You hear a gentle hum as the weapons power up.
function Combat_YouHearAGentleHumAs(name, line, wildcards)
  CurrentGlobalSound = PlayCombatSound("Space/WeaponsOn.ogg")
  if (ConfigTable.Settings.AlarmSounds == 1) then
    CurrentGlobalSound = PlayCombatSound("Space/RedStart.ogg")
  end
end

-- A loud klaxon sounds as red lights continue to flash overhead.
function Combat_ALoudKlaxonSoundsAsRed(name, line, wildcards)
  if (ConfigTable.Settings.AlarmSounds == 1) then
    CurrentGlobalSound = PlayCombatSound("Space/RedAlert.ogg")
  end
end

-- The walls and ceiling continue to pulse a crimson color as loud klaxons scream their warnings.
function Combat_TheWallsAndCeilingContinueTo(name, line, wildcards)
  if (ConfigTable.Settings.AlarmSounds == 1) then
    CurrentGlobalSound = PlayCombatSound("Space/RedAlert.ogg")
  end
end

-- Red alert lights come to life as the starship is attacked by an opponent.
function Combat_RedAlertLightsComeToLife(name, line, wildcards)
  CurrentGlobalSound = PlayCombatSound("Space/WeaponsOn.ogg")
  if (ConfigTable.Settings.AlarmSounds == 1) then
    CurrentGlobalSound = PlayCombatSound("Space/RedStart.ogg")
  end
end

-- The walls and ceiling suddenly start glowing *
function Combat_TheWallsAndCeilingSuddenlyStart(name, line, wildcards)
  if (string.match(wildcards[1], "blood")) then
    CurrentGlobalSound = PlayCombatSound("Space/WeaponsOn.ogg")
  elseif (string.match(wildcards[1], "blue")) then
    CurrentGlobalSound = PlayCombatSound("Space/WeaponsOff.ogg")
  end
end

-- The interior lighting turns to pulsating yellow.
function Combat_TheInteriorLightingTurnsToPulsating(name, line, wildcards)
  CurrentGlobalSound = PlayCombatSound("Space/WeaponsOff.ogg")
end

-- The overhead lights change to solid green.
function Combat_TheOverheadLightsChangeToSolid(name, line, wildcards)
  CurrentGlobalSound = PlayCombatSound("Space/WeaponsOff.ogg")
end

-- The ship vibrates mildly as torpedoes are launched.
function Combat_TheShipVibratesMildlyAsTorpedoes(name, line, wildcards)
  panning = math.random(-100, 100)
  CurrentCombatSound = PlayCombatSound("Space/TorpedoFire.ogg", panning)
  CurrentCombatSound = PlayCombatSound("Space/Torpedoes"..math.random(1, 3)..".ogg", panning)
end

-- * has launched * at *!
function Combat_HasLaunchedAt(name, line, wildcards)
  if (string.match(wildcards[2], "missile")) then
    CurrentCombatSound = PlayCombatSound("Space/OtherMissiles.ogg")
    if (string.match(wildcards[1], "X-Loritan Assassin")) then
      CurrentCombatSound = PlayCombatSound("Space/GrapeShot.ogg")
    end
    Note(line)
  elseif (string.match(wildcards[2], "torpedo")) then
    CurrentCombatSound = PlayCombatSound("Space/OtherTorpedoes.ogg")
    Note(line)
  end
end

-- The starship shakes and rattles as armor piercing shells are launched.
function Combat_TheStarshipShakesAndRattlesAs(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/ArmorPiercingShells"..math.random(1, 3)..".ogg", math.random(-100, 100))
end

-- You hear a thud as guided missiles are launched into space.
function Combat_YouHearAThudAsGuided(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouMissile"..math.random(1, 3)..".ogg", math.random(-100, 100))
end

-- The ship shudders as the lasers are fired.
function Combat_TheShipShuddersAsTheLasers(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/LaserFire"..math.random(1, 4)..".ogg", math.random(-100, 100))
end

-- The ship starts to vibrate as the long-range laser begins to draw energy.
function Combat_TheShipStartsToVibrateAs(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/PowerBuildUp"..math.random(1, 2)..".ogg")
end

-- * has fired at *.
function Combat_HasFiredAt(name, line, wildcards)
  if (string.match(wildcards[1], "X-Loritan")) then
    CurrentCombatSound = PlayCombatSound("Space/OtherFired"..math.random(1, 5)..".ogg")
  else
    CurrentCombatSound = PlayCombatSound("Space/OtherFired"..math.random(1, 5)..".ogg")
    Note(line)
  end
end

-- The vehicle shudders as *
function Combat_TheVehicleShuddersAs(name, line, wildcards)
  if (string.match(wildcards[1], "it begins to explode")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/RelicExploding"..math.random(1, 2)..".ogg")
  elseif (string.match(wildcards[1], "machine guns are fired")) then
    CurrentCombatSound = PlayCombatSound("Space/Weapons"..math.random(1, 5)..".ogg")
  elseif (string.match(wildcards[1], "cannons are fired")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/SalvageLaunch.ogg")
  elseif (string.match(wildcards[1], "missiles are launched")) then
    CurrentCombatSound = PlayCombatSound("Space/YouMissile"..math.random(1, 3)..".ogg")
  elseif (string.match(wildcards[1], "a grenade is launched toward a target")) then
    CurrentCombatSound = PlayCombatSound("Ground/GrenadeFire.ogg")
  elseif (string.match(wildcards[1], "a grenade comes in contact with its armor and explodes")) then
    CurrentCombatSound = PlayCombatSound("Ground/GrenadeExplode.ogg")
  end
end

-- * has fired * at *
function Combat_HasFiredAt2(name, line, wildcards)
  if (string.match(wildcards[2], "minicannons")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Misc/SalvageLaunch.ogg")
  elseif (string.match(wildcards[2], "a greenade")) then
    CurrentCombatSound = PlayCombatSound("Ground/GrenadeFire.ogg")
  elseif (string.match(wildcards[2], "a massive energy beam")) then
    if (string.match(wildcards[1], "X-Loritan") or string.match(wildcards[3], "X-Loritan")) then
      CurrentCombatSound = PlayCombatSound("Space/OtherFired"..math.random(1, 5)..".ogg")
    else
      CurrentCombatSound = PlayCombatSound("Space/OtherFired"..math.random(1, 5)..".ogg")
      Note(line)
    end
  end
end

-- * has a lock on this starship.
function Combat_HasALockOnThisStarship(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/LockedOnYou.ogg")
end

-- The ship lurches as the cutting beam destroys the shipwreck into millions of tiny pieces!
function Combat_TheShipLurchesAsTheCutting(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/OtherDestroyed"..math.random(1, 8)..".ogg")
end

-- The ship suddenly lurches violently as something hits it!
function Combat_TheShipSuddenlyLurchesViolentlyAs(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg", math.random(-100, 100))
  CurrentCombatSound = PlayCombatSound("Space/Reflectors"..math.random(1, 3)..".ogg", math.random(-100, 100))
end

-- A compacted mass of energy slams into *
function Combat_ACompactedMassOfEnergySlams(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/LRL4.ogg", math.random(-100, 100))
end

-- The viewscreen*switches to a pictograph of *.
function Combat_TheViewscreenSwitchesToAPictograph(name, line, wildcards)
  if (string.match(wildcards[2], "flying out of the circle")) then
    CurrentGlobalSound = PlayGlobalSound("Starship/Move/ExitSector"..math.random(1, 2)..".ogg")
  elseif (string.match(wildcards[2], "with a red circle around it")) then
    CurrentCombatSound = PlayCombatSound("Space/PowerBuildUp"..math.random(1, 2)..".ogg")
  elseif (string.match(wildcards[2], "with a dagger through it")) then
    CurrentCombatSound = PlayCombatSound("Space/LRL"..math.random(1, 5)..".ogg")
  end
end

-- * has harmlessly discharged a massive energy beam into space.
function Combat_HasHarmlesslyDischargedAMassiveEnergy(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/LRL"..math.random(1, 5)..".ogg", math.random(-100, 100))
end

-- You hear the death cry of *!
function Combat_YouHearTheDeathCryOf(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Ground/DeathMob"..math.random(1, 5)..".ogg")
end

-- The corpse of * falls onto * with a thud.
function Combat_TheCorpseOfFallsOntoWith(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Ground/Dead.ogg")
end

-- A corpse of*rapidly decays into dust.
function Combat_ACorpseOfRapidlyDecaysInto(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Ground/DecayingCorpse.ogg")
end

-- The corpse of * slowly decays.
function Combat_TheCorpseOfSlowlyDecays(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Ground/DecayingCorpse.ogg")
end

-- * take*aim at * with *!
-- True when the weapon is just "a rifle", "a shotgun", "a sniper" or "a pistol" (an
-- optional "s " in front, from "fires a rifle"). A real weapon always has a description
-- ("an alien laser sniper", "a sleak sniper weapon"), so a bare one is a player's emote.
local function is_bare_gun(text)
  local bare = string.match(string.lower(text), "^s?%s*an? (%a+)$")
  if bare then
    for g = 1, #guns do
      if bare == guns[g] then
        return true
      end
    end
  end
  return false
end

-- wildcards: 1 = who, 2 = the end of "take", 3 = the target, 4 = the weapon
function Combat_TakeAimAtWith(name, line, wildcards)
  if is_bare_gun(wildcards[4]) then
    Note(line)  -- an emote such as "takes aim at you with a sniper!": shown, no sound
    return
  end
  if (string.match(wildcards[1], "You")) then
    CurrentCombatSound = PlayCombatSound("Ground/Aiming.ogg")
    if (ConfigTable.Settings.SpeakSniperTarget == 1) then
      Note("Targeted " .. wildcards[3] .. ".")
    end
  else
    CurrentCombatSound = PlayCombatSound("Ground/Aiming.ogg", math.random(-100, 100))
  end
end

-- * fire*!
-- wildcards: 1 = who, 2 = what follows "fire" (for example "s a black laser sniper")
function Combat_Fire(name, line, wildcards)
  -- A bare "fires a rifle!", "fires a shotgun!" and so on is a player's emote: show it,
  -- with no sound.
  if is_bare_gun(wildcards[2]) then
    Note(line)
    return
  end
  -- A ship's attack such as '... has fired a massive energy beam at X-Loritan ship 97!'
  -- ends in "!", so it lands here rather than on "* has fired * at *". Hand it over.
  local ship, weapon, target = string.match(line, "^(.-) has fired (.-) at (.*)$")
  if ship then
    Combat_HasFiredAt2(name, line, { ship, weapon, target })
    return
  end
  local played = false
  for g = 1, #guns do
    if (string.match(string.lower(wildcards[2]), string.lower(guns[g]))) then
      played = true
      if (string.match(wildcards[1], "You")) then
        CurrentCombatSound = PlayCombatSound("Ground/Lasers/Laser"..guns[g]..".ogg")
      else
        CurrentCombatSound = PlayCombatSound("Ground/Lasers/Laser"..guns[g]..".ogg", math.random(-100, 100))
      end
    end
  end
  if (string.match(wildcards[2], "at")) then
    if (string.match(wildcards[1], "breathe") or string.match(wildcards[1], "breathes")) then
      played = true
      CurrentCombatSound = PlayCombatSound("Ground/PyrianFireBreath.ogg")
    end
  end
  if (string.match(wildcards[2], "low%-level")) then  -- "%-" is a plain hyphen
    played = true
    if (string.match(wildcards[1], "You")) then
      CurrentCombatSound = PlayCombatSound("Ground/Lasers/LaserLowLevel.ogg")
    else
      CurrentCombatSound = PlayCombatSound("Ground/Lasers/LaserLowLevel.ogg", math.random(-100, 100))
    end
  end
  -- Anything else that only happens to contain "fire" and end in "!" (a ship named
  -- "Four alarm fire", a news item about fireballs) isn't weapon fire: show it as it is.
  if not played then
    Note(line)
  end
end

-- The beam dissolves into the air!
function Combat_TheBeamDissolvesIntoTheAir(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Ground/Lasers/LaserVanish.ogg")
end

-- ^(Your|.*\'s) shield turns the beam away\!$
function Combat_YourShieldTurnsTheBeamAway(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Ground/Lasers/LaserBlocked.ogg")
end

-- You hear distant weapon fire!
function Combat_YouHearDistantWeaponFire(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Ground/Lasers/LaserDouble"..math.random(1, 3)..".ogg")
end

-- The beam hits *!
function Combat_TheBeamHits(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Ground/Lasers/LaserHits.ogg")
end

-- * walks in from *.
function Combat_WalksInFrom(name, line, wildcards)
  if (string.match(wildcards[1], "X-Loritan") or string.match(wildcards[1], "alien creature")) then
    CurrentCombatSound = PlayCombatSound("Ground/Lores"..math.random(1, 2)..".ogg")
  end
end

-- * falls to * with a sickening thud!
-- Only creatures really fall like this, and the game always names them with "A" or "An"
-- ("An alien creature", "A Quagmire Gator"). A line starting with a player's name is an
-- emote ("emote falls to the floor with a sickening thud!"): it's shown, with no sound.
function Combat_FallsToWithASickeningThud(name, line, wildcards)
  local who = string.gsub(wildcards[1], "^%(From outside: ", "")
  who = string.gsub(who, "^%[Camera%] ", "")
  if not (string.match(who, "^An? ") or string.match(who, "^You")) then
    return
  end
  if (string.match(wildcards[1], "X-Loritan") or string.match(wildcards[1], "alien creature")) then
    CurrentCombatSound = PlayCombatSound("Ground/LoreDeath.ogg")
    CurrentCombatSound = PlayCombatSound("Ground/DeathMob"..math.random(1, 5)..".ogg")
  else
    CurrentCombatSound = PlayCombatSound("Ground/Dead.ogg")
  end
end

-- The laser beam flies around, hitting everyone in its path!
function Combat_TheLaserBeamFliesAroundHitting(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Ground/Lasers/LaserDouble"..math.random(1, 3)..".ogg")
end

-- The beam flies *!
function Combat_TheBeamFlies(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Ground/Lasers/LaserDouble"..math.random(1, 3)..".ogg", math.random(-100, 100))
end

-- You insert a laser energy pack into a laser supplier, pressing a button.
function Combat_YouInsertALaserEnergyPack(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Ground/PowerSupplierButton.ogg")
end

-- The energy discharges with a whoosh, and * discard* laser energy pack.
function Combat_TheEnergyDischargesWithAWhoosh(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Ground/PowerBoost.ogg")
end

-- * exits * dropship.
function Combat_ExitsDropship(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Ground/Lores"..math.random(1, 2)..".ogg")
end

-- The viewscreen is filled with brilliant white light as * explodes!
function Combat_TheViewscreenIsFilledWithBrilliant(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Ground/GrenadeExplode.ogg")
end

-- You plug * Armor Piercing Weapon Chip into the weapons board, uploading its firmware to the computers.
function Combat_YouPlugArmorPiercingWeaponChip(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Combat/Space/ArmorPiercingChipBegin.ogg")
end

-- The ship rocks slightly as its hull is impacted by parts of an exploding starship!
function Combat_TheShipRocksSlightlyAsIts(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg", math.random(-100, 100))
  CurrentCombatSound = PlayCombatSound("Space/Reflectors"..math.random(1, 3)..".ogg")
end

-- The ship shakes slightly when something impacts the hull.
function Combat_TheShipShakesSlightlyWhenSomething(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg", math.random(-100, 100))
end

-- You feel a jolt as the ship crashes into a small, previously unseen asteroid.
function Combat_YouFeelAJoltAsThe(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg", math.random(-100, 100))
end

-- The engines roar for a short moment, something blocking the ship's movement.
function Combat_TheEnginesRoarForAShort(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg")
end

-- The ship clips a derelict as it moves through the sector.
function Combat_TheShipClipsADerelictAs(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg")
end

-- You hear the screaming of metal as the ship flies straight into an unseen shipwreck.
function Combat_YouHearTheScreamingOfMetal(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg", math.random(-100, 100))
end

-- The defense shields strengthen for a moment to mitigate damage.
function Combat_TheDefenseShieldsStrengthenForA2(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/FireReflected.ogg")
end

-- * clutch*in * hand.
function Combat_ClutchInHand(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Ground/Wield"..math.random(1, 5)..".ogg")
end

-- * tuck*away *
function Combat_TuckAway(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Ground/Unwield.ogg")
end

-- * yank*from *.
function Combat_YankFrom(name, line, wildcards)
  if (string.match(wildcards[1], "You")) then
    CurrentCombatSound = PlayCombatSound("Ground/Disarm.ogg")
  else
    CurrentCombatSound = PlayCombatSound("Ground/Disarmed.ogg")
    Note("You are disarmed.")
  end
end

-- * attempt*to disarm * but fail*
function Combat_AttemptToDisarmButFail(name, line, wildcards)
  if (string.match(wildcards[1], "You")) then
    CurrentCombatSound = PlayCombatSound("Ground/DisarmingFailed.ogg")
    Note("Disarming failed!")
  else
    CurrentCombatSound = PlayCombatSound("Ground/DisarmFailed.ogg")
  end
end

-- * attempt*to disarm * but * hold*onto * weapon with a titan grip!
function Combat_AttemptToDisarmButHoldOnto(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Ground/TitanGrip"..math.random(1, 2)..".ogg")
end

-- ^(.*?) (is|are) here\.$
function Combat_IsAreHere(name, line, wildcards)
  if (string.match(wildcards[1], "X-Loritan") or string.match(wildcards[1], "alien creature")) then
    CurrentGlobalSound = PlayGlobalSound("Combat/Ground/Lores"..math.random(1, 2)..".ogg")
  end -- If.
end

-- You feel the ship shudder slightly as something impacts the hull.
function Combat_YouFeelTheShipShudderSlightly(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg", math.random(-100, 100))
end

-- The shields strengthen, absorbing most of the impact.
function Combat_TheShieldsStrengthenAbsorbingMostOf(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/Reflectors"..math.random(1, 3)..".ogg")
end

-- The ship rocks violently as something impacts the hull!
function Combat_TheShipRocksViolentlyAsSomething(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg")
end

-- You feel the ship jolt suddenly as something impacts the hull.
function Combat_YouFeelTheShipJoltSuddenly(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/YouHit"..math.random(1, 9)..".ogg")
end

-- The starship jolts to the side as armor piercing shells smack into it by *.
function Combat_TheStarshipJoltsToTheSide(name, line, wildcards)
  CurrentCombatSound = PlayCombatSound("Space/Reflectors"..math.random(1, 3)..".ogg")
end
