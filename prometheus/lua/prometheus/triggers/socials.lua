-- Socials and emotes.
-- Trigger functions for worlds/plugins/prometheus/socials.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- ^(An? .*) wormhole recall remote says in a synthesized voice \, "(.*)"$
function Socials_AnWormholeRecallRemoteSaysIn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Socials/Say.ogg")
  StopSound(CurrentRoomSound)
end

-- ^A robotic voice from (.*) wormhole transport console says\, "(.*)"\.$
function Socials_ARoboticVoiceFromWormholeTransport(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Socials/Say.ogg")
end

-- The monitor on * wormhole transport console flashes the words: *
function Socials_TheMonitorOnWormholeTransportConsole(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Socials/Say.ogg")
end

-- ^(.*) (takes?) a sip (of|from) (.*)\.$
function Socials_TakesASipOfFrom(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Socials/Drink.ogg")
end

-- ^(.*) obscenely (slurps?) up  (.*)\.$
function Socials_ObscenelySlurpsUp(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Socials/Drink.ogg")
end

-- ^(.*) (drains?) (.*) in one gulp, then (throws?) (.*) away\.$
function Socials_DrainsInOneGulpThenThrows(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Socials/Drink.ogg")
  if (ConfigTable.Settings.SocialSounds == 1) then
    CurrentGlobalSound = PlayGlobalSound("Socials/Burp"..math.random(1, 5)..".ogg")
  end
  CurrentGlobalSound = PlayGlobalSound("Socials/BreakingGlass3.ogg")
end

-- ^(.*) (takes?) a bite of (.*)\.$
function Socials_TakesABiteOf(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Socials/Eat.ogg")
end

-- ^(.*) (finishes|finish) the last of (.*)\!$
function Socials_FinishesFinishTheLastOf(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Socials/EatUp.ogg")
end

-- You see a glimpse of darkness ahead, and suddenly, you find yourself hitting the ground.
function Socials_YouSeeAGlimpseOfDarkness(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Socials/Collapse"..math.random(1, 3)..".ogg")
end

-- * throw*onto * where it shatters into several thousand tiny pieces!
function Socials_ThrowOntoWhereItShattersInto(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Socials/BreakingGlass"..math.random(1, 5)..".ogg")
end
