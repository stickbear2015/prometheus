-- Credits: exchanging, paying and checking your balance.
-- Trigger functions for worlds/plugins/prometheus/money.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- You exchange * credits for *
function Money_YouExchangeCreditsFor(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- You contribute * credits to the owner of this starship.
function Money_YouContributeCreditsToTheOwner(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- You sell * for * credits.
function Money_YouSellForCredits(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- You deposit * credits into *
function Money_YouDepositCreditsInto(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- You withdraw * credits from *
function Money_YouWithdrawCreditsFrom(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- CONGRATULATIONS! You won * credits!
function Money_CongratulationsYouWonCredits(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- You receive a * of * credits.
function Money_YouReceiveAOfCredits(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- You have * credits on hand and * bank credits.
function Money_YouHaveCreditsOnHandAnd(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ViewInfo.ogg")
end

-- You need * more points before you can raise your status.
function Money_YouNeedMorePointsBeforeYou(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ViewInfo.ogg")
end

-- You are * credits in debt.
function Money_YouAreCreditsInDebt(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ViewInfo.ogg")
end

-- You are given a loan of * credits. You are now * credits in debt. The loan increased your cash on hand by *
function Money_YouAreGivenALoanOf(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- You pay * credits * of your debt.
function Money_YouPayCreditsOfYourDebt(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- Transaction complete.
function Money_TransactionComplete(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- Your * informs you that * credits has been transfered to your account by *.
function Money_YourInformsYouThatCreditsHas(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end
