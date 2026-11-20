-- Belts, clips, wearing and removing things, Easter eggs.
-- Trigger functions for worlds/plugins/prometheus/items.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- You clip * to * weapon belt with * clips.
function Items_YouClipToWeaponBeltWith(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Belt1.ogg")
end

-- You unclip * from * weapon belt with * clips.
function Items_YouUnclipFromWeaponBeltWith(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Belt2.ogg")
end

-- You open * Easter egg... And find * inside!
function Items_YouOpenEasterEggAndFind(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/EggItem.ogg")
end

-- You wrap a*around your waist and clip the ends together.
function Items_YouWrapAAroundYourWaist(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ItemWear.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ItemWearBelt.ogg")
end

-- You unclip a*and remove it from around your waist.
function Items_YouUnclipAAndRemoveIt(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ItemWearBelt.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ItemUnwear.ogg")
end

-- ^(You|[A-Z][A-Za-z'-]+(?: [A-Z][A-Za-z'-]+){0,3}(?: [a-z]+ Designation)?) (don|dons|strap|straps|wear|wears) (.*?)\.$
-- Only lines starting with "You" or a character's name, then the verb: so channel
-- messages, descriptions, inventories, refusals and speech don't play the wear sound.
function Items_DonDonsStrapStrapsWearWears(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ItemWear.ogg")
end

-- You see * here.
function Items_YouSeeHere(name, line, wildcards)
  if (string.match(wildcards[1], "of materials") or string.match(wildcards[1], "Easter egg") or string.match(wildcards[1], "pumpkin") or string.match(wildcards[1], "Christmas bell") or string.match(wildcards[1], "chocolate box")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/EggItem.ogg")
  elseif (string.match(wildcards[1], "X-Loritan") or string.match(wildcards[1], "alien creature")) then
    if (string.match(wildcards[1], "corpse") or string.match(wildcards[1], "corpses")) then
      -- Play no sound, as corpses don't growl.
    end -- InnerIf.
  end -- OuterIf.
end
