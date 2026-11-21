-- The ship's furnishings: shower, toilet, drink mixer, canteen, chairs, doors, paper and beeping appliances.
-- Trigger functions for worlds/plugins/prometheus/household.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- * crumple*up into a ball and throw*it away.
function Household_CrumpleUpIntoABallAnd(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Paper"..math.random(1, 3)..".ogg")
end

-- * bullet-proof statue crumples like paper!
function Household_BulletProofStatueCrumplesLikePaper(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Paper"..math.random(1, 3)..".ogg")
end

-- In a sudden burst of anger at * bad luck, * tear*a PBS. Inc. lottery ticket up and throw*the pieces away!
function Household_InASuddenBurstOfAnger(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Paper"..math.random(1, 3)..".ogg")
end

-- * in-ship recharging station beeps, indicating that it's low on charge.
function Household_InShipRechargingStationBeepsIndicating(name, line, wildcards)
  -- fix this when possible.
  CurrentGlobalSound = PlayGlobalSound("General/Misc/OvenBeep.ogg")
end

-- *climb*into*shower.
function Household_ClimbIntoShower(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ShowerCurtainOpen.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ShowerCurtainClose.ogg")
end

-- *leave*the shower.
function Household_LeaveTheShower(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ShowerCurtainOpen.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ShowerCurtainClose.ogg")
end

-- ^(.*?)use(.*?)toilet(.*?)flush(.*?)\.$
function Household_UseToiletFlush(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ToiletFlush.ogg")
end

-- The*on*drink mixer starts to fill with liquid.
function Household_TheOnDrinkMixerStartsTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/DrinkMixerEnd.ogg")
end

-- *drink mixer starts humming quietly.
function Household_DrinkMixerStartsHummingQuietly(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/DrinkMixerStart.ogg")
end

-- *drink mixer beeps, indicating that the drink is ready.
function Household_DrinkMixerBeepsIndicatingThatThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/OvenBeep.ogg")
end

-- *carefully insert*drink disk into a slot on*drink mixer.
function Household_CarefullyInsertDrinkDiskIntoA(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/InsertDrinkDisk.ogg")
end

-- You fill*canteen*sink*.
function Household_YouFillCanteenSink(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/FillCanteen.ogg")
end

-- *pour*some*from*into*.
function Household_PourSomeFromInto(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Pour.ogg")
end

-- The door leading to The foyer swings *.
function Household_TheDoorLeadingToTheFoyer(name, line, wildcards)
  if (string.match(wildcards[1], "open")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/DoorOpen.ogg")
  elseif (string.match(wildcards[1], "shut")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/DoorClose.ogg")
  end -- if.
end

-- *open*the door leading out and exit*the apartment.
function Household_OpenTheDoorLeadingOutAnd(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/DoorOpen.ogg")
end

-- * turn*oven on.
function Household_TurnOvenOn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/OvenBeep.ogg")
end

-- * portable oven beeps, indicating that the food inside is ready.
function Household_PortableOvenBeepsIndicatingThatThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/OvenBeep.ogg")
end

-- The display of * portable oven indicates, 'Recharging...'
function Household_TheDisplayOfPortableOvenIndicates(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/OvenBeep.ogg")
end

-- * portable oven indicates that the recharging process is complete.
function Household_PortableOvenIndicatesThatTheRecharging(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/OvenBeep.ogg")
end
