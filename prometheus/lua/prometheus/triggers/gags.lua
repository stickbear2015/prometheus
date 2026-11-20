-- Lines that are only hidden, with no sound.
-- Trigger functions for worlds/plugins/prometheus/gags.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- ^(.*) (says|say)(.*?)\: (.*)$
function Gags_SaysSay(name, line, wildcards)
  if (ConfigTable.Settings.Accents == 1) then
    AddToHistory("Conversations", line)
  else
    AddToHistory("Conversations", wildcards[1] .. " " .. wildcards[2] .. ": " .. wildcards[4])
  end
end

-- ^(.*) translator announces(.*?)\, "(.*)"$
function Gags_TranslatorAnnounces(name, line, wildcards)
  AddToHistory("Conversations", line, wildcards[1] .. " " .. wildcards[2] .. ": ")
end

-- You pull*sifting net out of the water, empty.
function Gags_YouPullSiftingNetOutOf(name, line, wildcards)
  Note("Nothing found!")
end

-- ^\*\*\*(.*) has (arrived to answer (.*)\'s assist|resolved an assist from (.*))\.([\*\*\*]?)$
function Gags_HasArrivedToAnswerAssistResolved(name, line, wildcards)
  Note(Trim(string.gsub(line, "*", "")))
end
