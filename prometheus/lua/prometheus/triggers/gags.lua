-- Lines that are only hidden, with no sound.
-- Trigger functions for worlds/plugins/prometheus/gags.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- ^((?:\(From outside: )?[^\[:][^:]*) (says|say|asks|ask|exclaims|exclaim)\b([^:]*)\: (.*)$
-- (Lines starting with "[" are channel messages; they're left to the channel trigger.)
-- It's at sequence 50, before the game-event triggers, so someone saying words like
-- "push a button" or "firecracker" doesn't set off that game sound. No colon is allowed
-- before "says", so game text that only happens to contain "say" and a colon later on
-- isn't taken for speech, and "say" must be a whole word (not "saying").
-- Speech (say, ask, exclaim) goes into the Conversations buffer: the whole line with
-- accents on, or just "<name> <verb>: <message>" with them off.
function Gags_SaysSay(name, line, wildcards)
  if (ConfigTable.Settings.Accents == 1) then
    AddToHistory("Conversations", line)
  else
    AddToHistory("Conversations", wildcards[1] .. " " .. wildcards[2] .. ": " .. wildcards[4])
  end
end

-- ^(.*) translator announces(.*?)\, "(.*)"$
function Gags_TranslatorAnnounces(name, line, wildcards)
  AddToHistory("Conversations", line, wildcards[1] .. " " .. wildcards[2] .. ": " .. wildcards[3])
end

-- You pull*sifting net out of the water, empty.
function Gags_YouPullSiftingNetOutOf(name, line, wildcards)
  Note("Nothing found!")
end

-- ^\*\*\*(.*) has (arrived to answer (.*)\'s assist|resolved an assist from (.*))\.([\*\*\*]?)$
function Gags_HasArrivedToAnswerAssistResolved(name, line, wildcards)
  Note(Trim(string.gsub(line, "*", "")))
end
