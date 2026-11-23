-- Games: winning, losing and extra points.
-- Trigger functions for worlds/plugins/prometheus/games.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- You win!
function Games_YouWin(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/YouWin.ogg")
end

-- You lose!
function Games_YouLose(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/YouLose.ogg")
end

-- It seems that your guess was right!
function Games_ItSeemsThatYourGuessWas(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/YouWin.ogg")
end

-- Sorry, but your guess was wrong. *
function Games_SorryButYourGuessWasWrong(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/YouLose.ogg")
  Note(wildcards[1])
end
