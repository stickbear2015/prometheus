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
function Health_YouAreDead(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Death.ogg")
end

-- * is dead!
function Health_IsDead(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Death.ogg")
end
