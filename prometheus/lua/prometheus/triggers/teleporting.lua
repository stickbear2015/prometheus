-- Teleporters, wormholes, and people beaming in and out.
-- Trigger functions for worlds/plugins/prometheus/teleporting.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- Suddenly, you feel a pulling sensation behind your shoulderblades, and you are thrown into the swirling depths of a wormhole.
function Teleporting_SuddenlyYouFeelAPullingSensation(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Teleported.ogg")
  StopSound(CurrentRoomSound)
end

-- A blinding electric blue beam of light appears. After a few seconds, it disappears, leaving nothing in its wake.
function Teleporting_ABlindingElectricBlueBeamOf(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/PersonTeleportsIn.ogg")
end

-- * is surrounded by an electric blue light and vanishes.
function Teleporting_IsSurroundedByAnElectricBlue(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/PersonTeleportsOut.ogg")
end

-- You feel like you are about to go blind. The lights dance in front of your eyes, like a fireworks display.
function Teleporting_YouFeelLikeYouAreAbout(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/WormholeInt.ogg")
end

-- You become aware of a thundering rumble very close to your ear.
function Teleporting_YouBecomeAwareOfAThundering(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Teleported.ogg")
end

-- The hum from under the floor increases markedly.
function Teleporting_TheHumFromUnderTheFloor(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Teleported.ogg")
end

-- You hear the hum from beneath your feet increase markedly.
function Teleporting_YouHearTheHumFromBeneath(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Teleported.ogg")
end

-- * signal*the technician to begin the transport process.
function Teleporting_SignalTheTechnicianToBeginThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/TeleportActivate.ogg")
end

-- * encased in a fluctuating electric blue light and after a brief moment * disappear*into the great unknown.
function Teleporting_EncasedInAFluctuatingElectricBlue(name, line, wildcards)
  if (string.match(string.lower(wildcards[1]), "you are")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/TeleportActivate.ogg")
  else
    CurrentGlobalSound = PlayGlobalSound("General/Misc/TeleportActivate.ogg")
  end
end

-- * notice*a flash of light before * and after a brief second * appear*in a slight daze.
function Teleporting_NoticeAFlashOfLightBefore(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/PersonTeleportsIn.ogg")
end

-- The electric blue beam fades, and you notice that your surroundings have changed.
function Teleporting_TheElectricBlueBeamFadesAnd(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/PersonTeleportsIn.ogg")
end

-- The electric blue beam fades, leaving nothing in its wake.
function Teleporting_TheElectricBlueBeamFadesLeaving(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/PersonTeleportsOut.ogg")
end

-- The sparks multiply, until * are hidden from sight in an electric blue beam of light.
function Teleporting_TheSparksMultiplyUntilAreHidden(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/WormholeInt.ogg")
end

-- The sparks continue multiplying, until you are encased in an electric blue beam of light.
function Teleporting_TheSparksContinueMultiplyingUntilYou(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/WormholeInt.ogg")
end

-- Sparks start issuing from the disc. As time passes, the sparks become more and more numerous.
function Teleporting_SparksStartIssuingFromTheDisc(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/WormholeInt.ogg")
end

-- Sparks start shooting up from the disc you're standing on. As time passes, the sparks become more and more numerous.
function Teleporting_SparksStartShootingUpFromThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/WormholeInt.ogg")
end
