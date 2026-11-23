-- Medical drones, healing and death.
-- Trigger functions for worlds/plugins/prometheus/health.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- The medical drones begin healing your wounds.
function Health_TheMedicalDronesBeginHealingYour(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/MedicalOperation.ogg")
end

-- * instruct*the medical drones to heal *
function Health_InstructTheMedicalDronesToHeal(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/MedicalOperation.ogg")
end

-- * feel*refreshed and full of energy as the healing finishes.
function Health_FeelRefreshedAndFullOfEnergy(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/MedicalEnd.ogg")
end

-- The drones stop healing *
function Health_TheDronesStopHealing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/MedicalEnd.ogg")
end

-- You are dead!
-- (An emote can't fake this one: an emote always starts with the player's name.)
-- There's no trigger for "* is dead!" any more (removed 2026-11-20, #44). In real logs
-- every such room line was a player's emote ("emote is dead!"), not a real death. Real
-- deaths come over the [Death] channel as "<name> has died.", which plays its own sound.
function Health_YouAreDead(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Death.ogg")
end
