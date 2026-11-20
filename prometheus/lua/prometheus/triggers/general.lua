-- Everything else: devices, items, doors, misc messages.
-- Trigger functions for worlds/plugins/prometheus/general.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- [Input]
function General_Input(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Username:
function General_Username(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Password:
function General_Password(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- The sharp noise of a piercing arrow cutting through space can be heard before * deposited.
function General_TheSharpNoiseOfAPiercing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/arrowImpact.ogg")
end

-- Report complete.
function General_ReportComplete(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- Suggestion sent.
function General_SuggestionSent(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- ^Wait (\d+) (seconds?|minutes?)\.$
function General_WaitSecondsMinutes(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Your application has been submitted.
function General_YourApplicationHasBeenSubmitted(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- Thank you for your answer!
function General_ThankYouForYourAnswer(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- Application submitted. Randomly check your hypermail to see your application status.
function General_ApplicationSubmittedRandomlyCheckYourHypermail(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- The starship completes surveying the planet.
function General_TheStarshipCompletesSurveyingThePlanet(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- Announcement from *: *
function General_AnnouncementFrom(name, line, wildcards)
  Execute("history_add All=Game Announcement from " .. wildcards[1] .. ": " .. wildcards[2])
  Execute("history_add GameAnnouncements=Announcement from " .. wildcards[1] .. ": " .. wildcards[2])
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Announcement.ogg")
end

-- [SUB-ANNOUNCEMENT | *]: "*"
function General_SubAnnouncement(name, line, wildcards)
  Execute("history_add All=Game Sub-Announcement from " .. wildcards[1] .. ": " .. wildcards[2])
  Execute("history_add GameAnnouncements=Game Sub-Announcement from " .. wildcards[1] .. ": " .. wildcards[2])
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/SubAnnouncement.ogg")
end

-- [CHANGES] *: *
function General_Changes(name, line, wildcards)
  Execute("history_add All=Game Changes: " .. wildcards[2] .. " (Category: " .. wildcards[1] .. ")")
  Execute("history_add GameChanges=" .. wildcards[1] .. ": " .. wildcards[2])
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/GameChange"..math.random(1, 2)..".ogg")
end

-- * crumple*up into a ball and throw*it away.
function General_CrumpleUpIntoABallAnd(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Paper"..math.random(1, 3)..".ogg")
end

-- * bullet-proof statue crumples like paper!
function General_BulletProofStatueCrumplesLikePaper(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Paper"..math.random(1, 3)..".ogg")
end

-- In a sudden burst of anger at * bad luck, * tear*a PBS. Inc. lottery ticket up and throw*the pieces away!
function General_InASuddenBurstOfAnger(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Paper"..math.random(1, 3)..".ogg")
end

-- ^Attention\! (.*)$
function General_Attention(name, line, wildcards)
  Execute("history_add All=" .. wildcards[1])
  Execute("history_add NewsFlash=" .. wildcards[1])
  CurrentGlobalSound = PlayGlobalSound("General/Misc/News.ogg")
end

-- ^\*\*\* Notice from (.*) \*\*\*$
function General_NoticeFrom(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/NewsFlash.ogg")
end

-- Suddenly, you feel a pulling sensation behind your shoulderblades, and you are thrown into the swirling depths of a wormhole.
function General_SuddenlyYouFeelAPullingSensation(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Teleported.ogg")
  StopSound(CurrentRoomSound)
end

-- No repair drones available.
function General_NoRepairDronesAvailable(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Only owners can do this.
function General_OnlyOwnersCanDoThis(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You can't * while *.
function General_YouCanWhile(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You must wait another * while the * generator recharges.
function General_YouMustWaitAnotherWhileThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Repair the * first.
function General_RepairTheFirst(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The ship is already in the process of harvesting *.
function General_TheShipIsAlreadyInThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You cannot teleport * a ship with active shields.
function General_YouCannotTeleportAShipWith(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You cannot salvage while the ship is in motion.
function General_YouCannotSalvageWhileTheShip(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The ship is currently unable to move.
function General_TheShipIsCurrentlyUnableTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You should stop the ship before attempting this.
function General_YouShouldStopTheShipBefore(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Unlock the beam first.
function General_UnlockTheBeamFirst(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The starship's NAVI drive is already engaged.
function General_TheStarshipNaviDriveIsAlready(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Please do not attempt to salvage while your ship is in the midst of probing a derelict starship.
function General_PleaseDoNotAttemptToSalvage(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Wait for the acceleration to hyperspace first.
function General_WaitForTheAccelerationToHyperspace(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Please deactivate * first.
function General_PleaseDeactivateFirst(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The power controls of this ship are locked due to it being under construction.
function General_ThePowerControlsOfThisShip(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The weapons are not powered up.
function General_TheWeaponsAreNotPoweredUp(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You cannot deploy probes while the starship is moving.
function General_YouCannotDeployProbesWhileThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You cannot salvage while landing.
function General_YouCannotSalvageWhileLanding(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The hum of the recharge falls silent as the batteries of the vehicle become full.
function General_TheHumOfTheRechargeFalls(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- You hear an odd whoosh as the stored charge is discarded.
function General_YouHearAnOddWhooshAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  Note("Charge discarded.")
end

-- The hum subsides and finally falls silent as the batteries finish recharging.
function General_TheHumSubsidesAndFinallyFalls(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- * in-ship recharging station beeps, indicating that it's low on charge.
function General_InShipRechargingStationBeepsIndicating(name, line, wildcards)
  -- fix this when possible.
  CurrentGlobalSound = PlayGlobalSound("General/Misc/OvenBeep.ogg")
end

-- *climb*into*shower.
function General_ClimbIntoShower(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ShowerCurtainOpen.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ShowerCurtainClose.ogg")
end

-- *leave*the shower.
function General_LeaveTheShower(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ShowerCurtainOpen.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ShowerCurtainClose.ogg")
end

-- ^(.*?)use(.*?)toilet(.*?)flush(.*?)\.$
function General_UseToiletFlush(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ToiletFlush.ogg")
end

-- The*on*drink mixer starts to fill with liquid.
function General_TheOnDrinkMixerStartsTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/DrinkMixerEnd.ogg")
end

-- *drink mixer starts humming quietly.
function General_DrinkMixerStartsHummingQuietly(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/DrinkMixerStart.ogg")
end

-- *drink mixer beeps, indicating that the drink is ready.
function General_DrinkMixerBeepsIndicatingThatThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/OvenBeep.ogg")
end

-- *carefully insert*drink disk into a slot on*drink mixer.
function General_CarefullyInsertDrinkDiskIntoA(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/InsertDrinkDisk.ogg")
end

-- You fill*canteen*sink*.
function General_YouFillCanteenSink(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/FillCanteen.ogg")
end

-- *pour*some*from*into*.
function General_PourSomeFromInto(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Pour.ogg")
end

-- ^(.*?)turn(.*?)sink(.*?)on(.*?)wash(.*?)hands\.$
function General_TurnSinkOnWashHands(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/WashingHands.ogg")
end

-- * is carried into the room in the center of a flaming circle.
function General_IsCarriedIntoTheRoomIn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/FireBolt.ogg")
end

-- * reforms into the legendary human wizard... And disappears in a circle of flames!
function General_ReformsIntoTheLegendaryHumanWizard(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/FlameVanish.ogg")
end

-- * suddenly step*from the background.
function General_SuddenlyStepFromTheBackground(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/HostIn"..math.random(1, 3)..".ogg")
end

-- * suddenly seem*to disappear into the background.
function General_SuddenlySeemToDisappearIntoThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/HostOut"..math.random(1, 3)..".ogg")
end

-- * has restored you to full health!
function General_HasRestoredYouToFullHealth(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Health.ogg")
end

-- ^\*\*\* The server will be shut down by .* in .*$
function General_TheServerWillBeShutDown(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Announcement.ogg")
end

-- Number of new announcements since last visit: *
function General_NumberOfNewAnnouncementsSinceLast(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Announcement.ogg")
end

-- Movement fixed.
function General_MovementFixed(name, line, wildcards)
  if (ConfigTable.Settings.Roundtime == 1) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Roundtime.ogg")
  end
end

-- Fixed.
function General_Fixed(name, line, wildcards)
  if (ConfigTable.Settings.Roundtime == 1) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Roundtime.ogg")
  end
end

-- Roundtime fixed.
function General_RoundtimeFixed(name, line, wildcards)
  if (ConfigTable.Settings.Roundtime == 1) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Roundtime.ogg")
  end
end

-- ^(\d+) (second|minute) (stun|round)time\.$
function General_SecondMinuteStunRoundTime(name, line, wildcards)
  if (ConfigTable.Settings.Roundtime == 1) then
    if (string.match(wildcards[2], "minute")) then
      DoAfterSpecial((tonumber(wildcards[1]) * 60), 'CurrentGlobalSound = PlayGlobalSound("General/Misc/Roundtime.ogg")', sendto.script)
    elseif (string.match(wildcards[2], "second")) then
      DoAfterSpecial(wildcards[1], 'CurrentGlobalSound = PlayGlobalSound("General/Misc/Roundtime.ogg")', sendto.script)
    end
  end
end

-- You raise your status to *!
function General_YouRaiseYourStatusTo(name, line, wildcards)
  Execute("history_add All=" .. line)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/LevelUp.ogg")
end

-- No shipwrecks found. Cannot continue grabbing process.
function General_NoShipwrecksFoundCannotContinueGrabbing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Hyperspace drive could not be activated due to the vessle being in motion.
function General_HyperspaceDriveCouldNotBeActivated(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The sublight drive is still recharging: * remaining.
function General_TheSublightDriveIsStillRecharging(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- That target is no longer here.
function General_ThatTargetIsNoLongerHere(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The ship is already salvaging.
function General_TheShipIsAlreadySalvaging(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The * is already firing.
function General_TheIsAlreadyFiring(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- * WELCOME BACK TO PROMETHEUS! *
function General_WelcomeBackToPrometheus(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/LoggedOn.ogg")
end

-- * Redirecting connection to this port... *
function General_RedirectingConnectionToThisPort(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/LoggedOn.ogg")
end

-- You ask * if * would like to establish a private communications link.
function General_YouAskIfWouldLikeTo(name, line, wildcards)
  Execute("history_add All=" .. line)
  Execute("history_add Private Communication=" .. line)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- A new poll has been opened. Use vote to answer it.
function General_ANewPollHasBeenOpened(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Poll.ogg")
end

-- Your vote has been recorded. Thank you for voting!
function General_YourVoteHasBeenRecordedThank(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- The polls are now closed.
function General_ThePollsAreNowClosed(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- >> Command Aborted <<
function General_CommandAborted(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
  Note("Aborted.")
end

-- Buying less than one? Nice try!
function General_BuyingLessThanOneNiceTry(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Invalid*
function General_Invalid(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Oops, wrong amount!
function General_OopsWrongAmount(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- * tr*to enter *, but * turned away by the locked hatch.
function General_TrToEnterButTurnedAway(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/CantGo"..math.random(1, 5)..".ogg")
end

-- You hear somebody trying to enter the ship.
function General_YouHearSomebodyTryingToEnter(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/CantGo"..math.random(1, 5)..".ogg")
end

-- *[Enter *yes* or *no*]
function General_EnterYesOrNo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- [Type *, *]
function General_Type(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- There are more than one matches to that argument in your links. Please be more specific.
function General_ThereAreMoreThanOneMatches(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- You exchange * credits for *
function General_YouExchangeCreditsFor(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- You contribute * credits to the owner of this starship.
function General_YouContributeCreditsToTheOwner(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- You sell * for * credits.
function General_YouSellForCredits(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- You deposit * credits into *
function General_YouDepositCreditsInto(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- You withdraw * credits from *
function General_YouWithdrawCreditsFrom(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- CONGRATULATIONS! You won * credits!
function General_CongratulationsYouWonCredits(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- You receive a * of * credits.
function General_YouReceiveAOfCredits(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- You have * credits on hand and * bank credits.
function General_YouHaveCreditsOnHandAnd(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ViewInfo.ogg")
end

-- You need * more points before you can raise your status.
function General_YouNeedMorePointsBeforeYou(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ViewInfo.ogg")
end

-- You are * credits in debt.
function General_YouAreCreditsInDebt(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ViewInfo.ogg")
end

-- You are given a loan of * credits. You are now * credits in debt. The loan increased your cash on hand by *
function General_YouAreGivenALoanOf(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- You pay * credits * of your debt.
function General_YouPayCreditsOfYourDebt(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- Transaction complete.
function General_TransactionComplete(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- Your * informs you that * credits has been transfered to your account by *.
function General_YourInformsYouThatCreditsHas(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Credits"..math.random(1, 4)..".ogg")
end

-- I don't understand that.
function General_DonUnderstandThat(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Command"..math.random(1, 4)..".ogg")
end

-- * type*a complicated series of code*into * translator.
function General_TypeAComplicatedSeriesOfCode(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("PyrianChitter"..math.random(1, 10)..".ogg")
end

-- The door leading to The foyer swings *.
function General_TheDoorLeadingToTheFoyer(name, line, wildcards)
  if (string.match(wildcards[1], "open")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/DoorOpen.ogg")
  elseif (string.match(wildcards[1], "shut")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/DoorClose.ogg")
  end -- if.
end

-- *open*the door leading out and exit*the apartment.
function General_OpenTheDoorLeadingOutAnd(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/DoorOpen.ogg")
end

-- A weapon is already being repaired.
function General_AWeaponIsAlreadyBeingRepaired(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You can't teleport for *.
function General_YouCanTeleportFor(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- * to autopilot first.
function General_ToAutopilotFirst(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- * to manual pilot first.
function General_ToManualPilotFirst(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The starship is already moving.
function General_TheStarshipIsAlreadyMoving(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Hyperspace jumps cannot be aborted.
function General_HyperspaceJumpsCannotBeAborted(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The * is already in that sector.
function General_TheIsAlreadyInThatSector(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The * is not moving.
function General_TheIsNotMoving(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The * is already moving.
function General_TheIsAlreadyMoving(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You're already there.
function General_YouReAlreadyThere(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Hyperspace jump not possible while shielded.
function General_HyperspaceJumpNotPossibleWhileShielded(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The launchers do not need reloading.
function General_TheLaunchersDoNotNeedReloading(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- There are still * left in the banks.
function General_ThereAreStillLeftInThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Invalid coordinates. Range: * to *
function General_InvalidCoordinatesRangeTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- A red light on the docking console turns on.
function General_ARedLightOnTheDocking(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- The yellow light turns to green.
function General_TheYellowLightTurnsToGreen(name, line, wildcards)
  StopSound(CurrentGlobalSound)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- * snatch*from the cold, cruel hands of space.
function General_SnatchFromTheColdCruelHands(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/SnatchArtifact"..math.random(1, 2)..".ogg")
end

-- * indicate*to * that * wish*for * to follow *.
function General_IndicateToThatWishForTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupJoin.ogg")
end

-- You follow *.
function General_YouFollow(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupFollow.ogg")
end

-- * follow*you into the area.
function General_FollowYouIntoTheArea(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupFollow.ogg")
end

-- * request*that * no longer follow *.
function General_RequestThatNoLongerFollow(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupDisband.ogg")
end

-- * ha* away from * group.
function General_HaAwayFromGroup(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupDisband.ogg")
end

-- * left you behind.
function General_LeftYouBehind(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupDisband.ogg")
end

-- * start*following *.
function General_StartFollowing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupJoin.ogg")
end

-- * stop*following *.
function General_StopFollowing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupDisband.ogg")
end

-- * disband*group.
function General_DisbandGroup(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/GroupDisband.ogg")
end

-- * toggle*the starships alert status to a * state.
function General_ToggleTheStarshipsAlertStatusTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- The starship is already on * alert.
function General_TheStarshipIsAlreadyOnAlert(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You hear the hum fade as the weapons power down.
function General_YouHearTheHumFadeAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- Those coordinates are too far away to establish a lock.
function General_ThoseCoordinatesAreTooFarAway(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Those controls are already in use.
function General_ThoseControlsAreAlreadyInUse(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The vibration ceases as the long-range laser powers down.
function General_TheVibrationCeasesAsTheLong(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- The roar of the engine calms as the starship completes its launch.
function General_TheRoarOfTheEngineCalms(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Background"..math.random(1, 5)..".ogg")
end

-- Either the launchers do not need reloading, or the ship lacks the required ammunition.
function General_EitherTheLaunchersDoNotNeed(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Grabbing is already in progress.
function General_GrabbingIsAlreadyInProgress(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You cannot grab any more.
function General_YouCannotGrabAnyMore(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- A low hum starts in the background as the batteries begin recharging.
function General_ALowHumStartsInThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- A soft hum starts somewhere within the bowels of the ship as the * banks are refilled.
function General_ASoftHumStartsSomewhereWithin(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/RefillingBanks.ogg")
end

-- The hum subsides as the * bank refilling completes.
function General_TheHumSubsidesAsTheBank(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- The low hum fades away as the shields finish recharging.
function General_TheLowHumFadesAwayAs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- The rumble beneath your feet eases off as the refinery powers down.
function General_TheRumbleBeneathYourFeetEases(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- The ship slows down as it comes closer to the final destination.
function General_TheShipSlowsDownAsIt(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Computer/Beep"..math.random(1, 5)..".ogg")
end

-- The ship suddenly shoots out of the rift and into another sector. The rift rapidly shrinks and disappears.
function General_TheShipSuddenlyShootsOutOf(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Computer/Beep"..math.random(1, 5)..".ogg")
  CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Background"..math.random(1, 5)..".ogg")
end

-- With a final jolt, the starship slows as it exits the Worldway.
function General_WithAFinalJoltTheStarship(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- Would you like to drive out of the ship's vehicle hatch*
function General_WouldYouLikeToDriveOut(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- A blinding electric blue beam of light appears. After a few seconds, it disappears, leaving nothing in its wake.
function General_ABlindingElectricBlueBeamOf(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/PersonTeleportsIn.ogg")
end

-- * is surrounded by an electric blue light and vanishes.
function General_IsSurroundedByAnElectricBlue(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/PersonTeleportsOut.ogg")
end

-- * appears in a puff of smoke!
function General_AppearsInAPuffOfSmoke(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Smoke"..math.random(1, 3)..".ogg")
end

-- You feel like you are about to go blind. The lights dance in front of your eyes, like a fireworks display.
function General_YouFeelLikeYouAreAbout(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/WormholeInt.ogg")
end

-- You become aware of a thundering rumble very close to your ear.
function General_YouBecomeAwareOfAThundering(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Teleported.ogg")
end

-- The hum from under the floor increases markedly.
function General_TheHumFromUnderTheFloor(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Teleported.ogg")
end

-- You hear the hum from beneath your feet increase markedly.
function General_YouHearTheHumFromBeneath(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Teleported.ogg")
end

-- * signal*the technician to begin the transport process.
function General_SignalTheTechnicianToBeginThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/TeleportActivate.ogg")
end

-- * encased in a fluctuating electric blue light and after a brief moment * disappear*into the great unknown.
function General_EncasedInAFluctuatingElectricBlue(name, line, wildcards)
  if (string.match(string.lower(wildcards[1]), "you are")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/TeleportActivate.ogg")
  else
    CurrentGlobalSound = PlayGlobalSound("General/Misc/TeleportActivate.ogg")
  end
end

-- * notice*a flash of light before * and after a brief second * appear*in a slight daze.
function General_NoticeAFlashOfLightBefore(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/PersonTeleportsIn.ogg")
end

-- The electric blue beam fades, and you notice that your surroundings have changed.
function General_TheElectricBlueBeamFadesAnd(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/PersonTeleportsIn.ogg")
end

-- The electric blue beam fades, leaving nothing in its wake.
function General_TheElectricBlueBeamFadesLeaving(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/PersonTeleportsOut.ogg")
end

-- The sparks multiply, until * are hidden from sight in an electric blue beam of light.
function General_TheSparksMultiplyUntilAreHidden(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/WormholeInt.ogg")
end

-- The sparks continue multiplying, until you are encased in an electric blue beam of light.
function General_TheSparksContinueMultiplyingUntilYou(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/WormholeInt.ogg")
end

-- Sparks start issuing from the disc. As time passes, the sparks become more and more numerous.
function General_SparksStartIssuingFromTheDisc(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/WormholeInt.ogg")
end

-- Sparks start shooting up from the disc you're standing on. As time passes, the sparks become more and more numerous.
function General_SparksStartShootingUpFromThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/WormholeInt.ogg")
end

-- * turn*oven on.
function General_TurnOvenOn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/OvenBeep.ogg")
end

-- * portable oven beeps, indicating that the food inside is ready.
function General_PortableOvenBeepsIndicatingThatThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/OvenBeep.ogg")
end

-- The display of * portable oven indicates, 'Recharging...'
function General_TheDisplayOfPortableOvenIndicates(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/OvenBeep.ogg")
end

-- * portable oven indicates that the recharging process is complete.
function General_PortableOvenIndicatesThatTheRecharging(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/OvenBeep.ogg")
end

-- * examine*the menu of available items.
function General_ExamineTheMenuOfAvailableItems(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Menu.ogg")
end

-- The ship slows down and you feel the sharp jolt as the ship touches down on the landing pad.
function General_TheShipSlowsDownAndYou(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- The low hum of the power transfer dies away, followed a split second later by a click as the power cable beneath the vehicle disconnects.
function General_TheLowHumOfThePower(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  Note("Recharge complete!")
end

-- You hear some clangs as the excavation equipment is retracted.
function General_YouHearSomeClangsAsThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("Space/Reflectors3.ogg")
end

-- Excavation impossible due to damaged equipment.
function General_ExcavationImpossibleDueToDamagedEquipment(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- How many artifacts do you wish to retrieve? Maximum is *. Hit enter to retrieve all of them.
function General_HowManyArtifactsDoYouWish(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
  CallPlugin("369e8998ba42093fcc9231a2","OnPluginCommandEntered",wildcards[1])
end

-- There are no destinations to which you can teleport at present.
function General_ThereAreNoDestinationsToWhich(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You can't go that way.
function General_YouCanGoThatWay(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/CantGo"..math.random(1, 5)..".ogg")
end

-- You hear somebody trying to enter the ship.
function General_YouHearSomebodyTryingToEnter2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/CantGo"..math.random(1, 5)..".ogg")
end

-- You clip * to * weapon belt with * clips.
function General_YouClipToWeaponBeltWith(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Belt1.ogg")
end

-- You unclip * from * weapon belt with * clips.
function General_YouUnclipFromWeaponBeltWith(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Belt2.ogg")
end

-- The medical drones begin healing your wounds.
function General_TheMedicalDronesBeginHealingYour(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/MedicalOperation.ogg")
end

-- * instruct*the medical drones to heal *
function General_InstructTheMedicalDronesToHeal(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/MedicalOperation.ogg")
end

-- * feel*refreshed and full of energy as the healing finishes.
function General_FeelRefreshedAndFullOfEnergy(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/MedicalEnd.ogg")
end

-- The drones stop healing *
function General_TheDronesStopHealing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/MedicalEnd.ogg")
end

-- Now viewing monitoring satellite *. This satellite is monitoring *.
function General_NowViewingMonitoringSatelliteThisSatellite(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Satellite.ogg")
  Note("Satellite report of " .. wildcards[2] .. ":")
end

-- * shout*, "*"
function General_Shout(name, line, wildcards)
  Execute("history_add All=" .. wildcards[1] .. " shout" .. wildcards[2] .. ": " .. wildcards[3])
  Execute("history_add Shouts=" .. wildcards[1] .. " shout" .. wildcards[2] .. ": " .. wildcards[3])
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Shouts.ogg")
  Note(wildcards[1] .. " shout" .. wildcards[2] .. ": " .. wildcards[3])
end

-- Thanks for playing!
function General_ThanksForPlaying(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Gift.ogg")
end

-- Oooooooo, look! You get some extra points! Yaaaayy!
function General_OoooooooLookYouGetSomeExtra(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/ThankYou.ogg")
  Note("The Prometheus hosts thank you for playing!")
end

-- Thank you for assisting!
function General_ThankYouForAssisting(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/ThankYou.ogg")
end

-- You receive * points!
function General_YouReceivePoints(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Points.ogg")
end

-- You*open *
function General_YouOpen(name, line, wildcards)
  if (string.match(wildcards[2], "container")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/ContainerOpen.ogg")
  elseif (string.match(wildcards[2], "food")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/FridgeOpen.ogg")
  elseif (string.match(wildcards[2], "oven")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/OvenDoorOpen.ogg")
  elseif (string.match(wildcards[2], "pot")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/ContainerOpen.ogg")
  elseif (string.match(wildcards[2], "drink mixer")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/DrinkMixerOpen.ogg")
  end
end

-- You*close *
function General_YouClose(name, line, wildcards)
  if (string.match(wildcards[2], "container")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/ContainerClose.ogg")
  elseif (string.match(wildcards[2], "food")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/FridgeClose.ogg")
  elseif (string.match(wildcards[2], "oven")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/OvenDoorClose.ogg")
  elseif (string.match(wildcards[2], "pot")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/ContainerClose.ogg")
  elseif (string.match(wildcards[2], "drink mixer")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/DrinkMixerClose.ogg")
  end
end

-- *bump*into the locked door leading *.
function General_BumpIntoTheLockedDoorLeading(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/CantGo"..math.random(1, 5)..".ogg")
end

-- Enter new security access code:
function General_EnterNewSecurityAccessCode(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Confirm new security access code:
function General_ConfirmNewSecurityAccessCode(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Enter old security access code for removal confirmation:
function General_EnterOldSecurityAccessCodeFor(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Enter the new username:
function General_EnterTheNewUsername(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Enter your current password:
function General_EnterYourCurrentPassword(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Enter your new password:
function General_EnterYourNewPassword(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Re-enter your new password:
function General_ReEnterYourNewPassword(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Username changed from * to *
function General_UsernameChangedFromTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- Password changed successfully.
function General_PasswordChangedSuccessfully(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- * floats into the room and comes to a stop in your hand.
function General_FloatsIntoTheRoomAndComes(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Drink.ogg")
end

-- * flies into the room and lands in your arms.
function General_FliesIntoTheRoomAndLands(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Food.ogg")
end

-- The hum subsides as * finish reloading.
function General_TheHumSubsidesAsFinishReloading(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- Letter successfully sent to *
function General_LetterSuccessfullySentTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- The * launchers are cooling down.
function General_TheLaunchersAreCoolingDown(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- * are already being fired.
function General_AreAlreadyBeingFired(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The LRL is recharging: * remaining.
function General_TheLrlIsRechargingRemaining(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- I see no "*" here.
function General_SeeNoHere(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- There are no salvage lines available.
function General_ThereAreNoSalvageLinesAvailable(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Things can only be transferred at a landing pad or when docked to another ship via the docking ring.
function General_ThingsCanOnlyBeTransferredAt(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You'll need to land at a properly equipped landing pad to transfer.
function General_YouLlNeedToLandAt(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Drive could not be activated due to the vessel being in motion.
function General_DriveCouldNotBeActivatedDue(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Please drop your shields first.
function General_PleaseDropYourShieldsFirst(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- * depart*to modify the game.
function General_DepartToModifyTheGame(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/GameModificationStart.ogg")
end

-- * finish*modifying the game.
function General_FinishModifyingTheGame(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/GameModificationStop.ogg")
end

-- A tradesman certificate has been created for you and can be found in your inventory.
function General_ATradesmanCertificateHasBeenCreated(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Certificate.ogg")
end

-- You can not scoop while the vehicle is moving.
function General_YouCanNotScoopWhileThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You can not move while attempting to scoop.
function General_YouCanNotMoveWhileAttempting(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- There is not a star in the sector.
function General_ThereIsNotAStarIn(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- * should not be moving.
function General_ShouldNotBeMoving(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You cannot use that in hyperspace.
function General_YouCannotUseThatInHyperspace(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Finish your hyper jump first.
function General_FinishYourHyperJumpFirst(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Hyperspace drive could not be activated due to the vessel being in motion.
function General_HyperspaceDriveCouldNotBeActivated2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Only * until Christmas!
function General_OnlyUntilChristmas(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Christmas.ogg")
end

-- You're no longer in that sector.
function General_YouReNoLongerInThat(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You are having a hard time using the controls do to your uncoordinated state.
function General_YouAreHavingAHardTime(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You have just received * Easter eggs as a gift! Found in your inventory!
function General_YouHaveJustReceivedEasterEggs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/EggHunt.ogg")
end

-- You open * Easter egg... And find * inside!
function General_YouOpenEasterEggAndFind(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/EggItem.ogg")
end

-- * enter*a shiny lift.
function General_EnterAShinyLift(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Movement.ogg")
end

-- * step*out of the lift.
function General_StepOutOfTheLift(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Movement.ogg")
end

-- You are dead!
function General_YouAreDead(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Death.ogg")
end

-- * is dead!
function General_IsDead(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Death.ogg")
end

-- You wrap a*around your waist and clip the ends together.
function General_YouWrapAAroundYourWaist(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ItemWear.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ItemWearBelt.ogg")
end

-- You unclip a*and remove it from around your waist.
function General_YouUnclipAAndRemoveIt(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ItemWearBelt.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ItemUnwear.ogg")
end

-- ^(.*?) (don|dons|strap|straps|wear|wears) (.*?)\.$
function General_DonDonsStrapStrapsWearWears(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ItemWear.ogg")
end

-- ^(.*) (remove|removes|unstrap|unstraps) (.*?)\.$
function General_RemoveRemovesUnstrapUnstraps(name, line, wildcards)
  if (string.match(wildcards[3], "your electronic gadgets first") or string.match(wildcards[3], "before")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
  elseif (string.match(wildcards[3], "from")) then
    -- Do nothing as this should be ignored.
  else
    CurrentGlobalSound = PlayGlobalSound("General/Misc/ItemUnwear.ogg")
  end -- If.
end

-- * begin*scribbling something on a PBS. Inc. lottery ticket...
function General_BeginScribblingSomethingOnAPbs(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Scribble.ogg")
end

-- You see * here.
function General_YouSeeHere(name, line, wildcards)
  if (string.match(wildcards[1], "of materials") or string.match(wildcards[1], "Easter egg") or string.match(wildcards[1], "pumpkin") or string.match(wildcards[1], "Christmas bell") or string.match(wildcards[1], "chocolate box")) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/EggItem.ogg")
  elseif (string.match(wildcards[1], "X-Loritan") or string.match(wildcards[1], "alien creature")) then
    if (string.match(wildcards[1], "corpse") or string.match(wildcards[1], "corpses")) then
      -- Play no sound, as corpses don't growl.
    end -- InnerIf.
  end -- OuterIf.
end

-- You win!
function General_YouWin(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/YouWin.ogg")
end

-- You lose!
function General_YouLose(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/YouLose.ogg")
end

-- It seems that your guess was right!
function General_ItSeemsThatYourGuessWas(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/YouWin.ogg")
end

-- Sorry, but your guess was wrong. *
function General_SorryButYourGuessWasWrong(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/YouLose.ogg")
  Note(wildcards[1])
end

-- Your command could not be executed at this time. *
function General_YourCommandCouldNotBeExecuted(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Traceback.ogg")
end

-- The * banks are already full.
function General_TheBanksAreAlreadyFull(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- *You were awarded * points for the resolution of report *
function General_YouWereAwardedPointsForThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/ThankYou.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Points.ogg")
  Note(Trim(string.gsub(line, "*", "")))
end

-- *You have unread personal announcements, displaying them now.*
function General_YouHaveUnreadPersonalAnnouncementsDisplaying(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/ThankYou.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/NewMail.ogg")
  Note(Trim(string.gsub(line, "*", "")))
end

-- * personally wants to thank you for playing Prometheus! As a token of appreciation, have this!
function General_PersonallyWantsToThankYouFor(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/ThankYou.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/AddCredits.ogg")
end

-- You step into a brilliant beam of light which whisks you back to your home.
function General_YouStepIntoABrilliantBeam(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Host"..math.random(1, 10)..".ogg")
end

-- Due to the amount of energy drawn by the cloaking generator, you can not fire weapons while cloaked.
function General_DueToTheAmountOfEnergy(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You already have that!
function General_YouAlreadyHaveThat(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- The equipment is non-functional when damaged. Please repair it fully before proceeding.
function General_TheEquipmentIsNonFunctionalWhen(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- There is nothing to be transfered.
function General_ThereIsNothingToBeTransfered(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- All drones are busy repairing.
function General_AllDronesAreBusyRepairing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- Distance: *.
function General_Distance(name, line, wildcards)
  if (tonumber(wildcards[1]) == 1) then
    CurrentGlobalSound = PlayGlobalSound("General/Misc/Roundtime.ogg")
  end
end

-- ^Verb programmed\.$
function General_VerbProgrammed(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/SaveSuccessful.ogg")
end

-- ^Verb not programmed\.$
function General_VerbNotProgrammed(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/SaveFailed.ogg")
end

-- Event mode is now enabled, which means that OOC channel access is unavailable. We hope you enjoy the event!
function General_EventModeIsNowEnabledWhich(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/EventsAdded.ogg")
end

-- Red lights on warning signs begin to flash, indicating that the ship is in the midst of a solar storm.
function General_RedLightsOnWarningSignsBegin(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Alarm.ogg")
end

-- The red lights on the solar storm warning signs stop flashing.
function General_TheRedLightsOnTheSolar(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Beep"..math.random(1, 5)..".ogg")
end

-- You begin your journey towards *.
function General_YouBeginYourJourneyTowards(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/SpeedwalkStart.ogg")
end

-- You arrive at *.
function General_YouArriveAt(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/SpeedwalkDestination.ogg")
end

-- * sanitation droid arrives.
function General_SanitationDroidArrives(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/SanitationDroidArrives.ogg")
end

-- * sanitation droid trundles around the area, collecting dropped items.
function General_SanitationDroidTrundlesAroundTheArea(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/SanitationDroidCollects.ogg")
end

-- * sanitation droid heads *.
function General_SanitationDroidHeads(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/SanitationDroidLeaves.ogg")
end

-- You can't lock on this ship!
function General_YouCanLockOnThisShip(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- You are having a hard time using the controls due to your uncoordinated state.
function General_YouAreHavingAHardTime2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Cancel.ogg")
end

-- *Type a destination name. Leave blank for a full menu, cancel with '@abort' or 'A'*
function General_TypeADestinationNameLeaveBlank(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
  CallPlugin("369e8998ba42093fcc9231a2","OnPluginCommandEntered",'btt')
end

-- You hear a ghostly moan echoing through the vast reaches of space.*
function General_YouHearAGhostlyMoanEchoing(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ghostSound.ogg")
end

-- You hear a ghostly moan echoing around you.
function General_YouHearAGhostlyMoanEchoing2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ghostMoan.ogg")
end

-- A long wailing cry shatters the silence.
function General_ALongWailingCryShattersThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/ghostMoan.ogg")
end
