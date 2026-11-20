-- Messages from the game itself: prompts, reports, announcements, news, hosts and logging in.
-- Trigger functions for worlds/plugins/prometheus/game.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- [Input]
function Game_Input(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Username:
function Game_Username(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Password:
function Game_Password(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Report complete.
function Game_ReportComplete(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- Suggestion sent.
function Game_SuggestionSent(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- Your application has been submitted.
function Game_YourApplicationHasBeenSubmitted(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- Thank you for your answer!
function Game_ThankYouForYourAnswer(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- Application submitted. Randomly check your hypermail to see your application status.
function Game_ApplicationSubmittedRandomlyCheckYourHypermail(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- Announcement from *: *
function Game_AnnouncementFrom(name, line, wildcards)
  Execute("history_add All=Game Announcement from " .. wildcards[1] .. ": " .. wildcards[2])
  Execute("history_add GameAnnouncements=Announcement from " .. wildcards[1] .. ": " .. wildcards[2])
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Announcement.ogg")
end

-- [SUB-ANNOUNCEMENT | *]: "*"
function Game_SubAnnouncement(name, line, wildcards)
  Execute("history_add All=Game Sub-Announcement from " .. wildcards[1] .. ": " .. wildcards[2])
  Execute("history_add GameAnnouncements=Game Sub-Announcement from " .. wildcards[1] .. ": " .. wildcards[2])
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/SubAnnouncement.ogg")
end

-- [CHANGES] *: *
function Game_Changes(name, line, wildcards)
  Execute("history_add All=Game Changes: " .. wildcards[2] .. " (Category: " .. wildcards[1] .. ")")
  Execute("history_add GameChanges=" .. wildcards[1] .. ": " .. wildcards[2])
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/GameChange"..math.random(1, 2)..".ogg")
end

-- ^Attention\! (.*)$
function Game_Attention(name, line, wildcards)
  Execute("history_add All=" .. wildcards[1])
  Execute("history_add NewsFlash=" .. wildcards[1])
  CurrentGlobalSound = PlayGlobalSound("General/Misc/News.ogg")
end

-- ^\*\*\* Notice from (.*) \*\*\*$
function Game_NoticeFrom(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/NewsFlash.ogg")
end

-- * suddenly step*from the background.
function Game_SuddenlyStepFromTheBackground(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/HostIn"..math.random(1, 3)..".ogg")
end

-- * suddenly seem*to disappear into the background.
function Game_SuddenlySeemToDisappearIntoThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/HostOut"..math.random(1, 3)..".ogg")
end

-- ^\*\*\* The server will be shut down by .* in .*$
function Game_TheServerWillBeShutDown(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Announcement.ogg")
end

-- Number of new announcements since last visit: *
function Game_NumberOfNewAnnouncementsSinceLast(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Announcement.ogg")
end

-- * WELCOME BACK TO PROMETHEUS! *
function Game_WelcomeBackToPrometheus(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/LoggedOn.ogg")
end

-- * Redirecting connection to this port... *
function Game_RedirectingConnectionToThisPort(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/LoggedOn.ogg")
end

-- You ask * if * would like to establish a private communications link.
function Game_YouAskIfWouldLikeTo(name, line, wildcards)
  Execute("history_add All=" .. line)
  Execute("history_add Private Communication=" .. line)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Your vote has been recorded. Thank you for voting!
function Game_YourVoteHasBeenRecordedThank(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- The polls are now closed.
function Game_ThePollsAreNowClosed(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- *[Enter *yes* or *no*]
function Game_EnterYesOrNo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- [Type *, *]
function Game_Type(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- There are more than one matches to that argument in your links. Please be more specific.
function Game_ThereAreMoreThanOneMatches(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Would you like to drive out of the ship's vehicle hatch*
function Game_WouldYouLikeToDriveOut(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- How many artifacts do you wish to retrieve? Maximum is *. Hit enter to retrieve all of them.
function Game_HowManyArtifactsDoYouWish(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
  CallPlugin("369e8998ba42093fcc9231a2","OnPluginCommandEntered",wildcards[1])
end

-- * shout*, "*"
function Game_Shout(name, line, wildcards)
  Execute("history_add All=" .. wildcards[1] .. " shout" .. wildcards[2] .. ": " .. wildcards[3])
  Execute("history_add Shouts=" .. wildcards[1] .. " shout" .. wildcards[2] .. ": " .. wildcards[3])
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Shouts.ogg")
  Note(wildcards[1] .. " shout" .. wildcards[2] .. ": " .. wildcards[3])
end

-- Thanks for playing!
function Game_ThanksForPlaying(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Gift.ogg")
end

-- Oooooooo, look! You get some extra points! Yaaaayy!
function Game_OoooooooLookYouGetSomeExtra(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/ThankYou.ogg")
  Note("The Prometheus hosts thank you for playing!")
end

-- Thank you for assisting!
function Game_ThankYouForAssisting(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/ThankYou.ogg")
end

-- Enter new security access code:
function Game_EnterNewSecurityAccessCode(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Confirm new security access code:
function Game_ConfirmNewSecurityAccessCode(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Enter old security access code for removal confirmation:
function Game_EnterOldSecurityAccessCodeFor(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Enter the new username:
function Game_EnterTheNewUsername(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Enter your current password:
function Game_EnterYourCurrentPassword(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Enter your new password:
function Game_EnterYourNewPassword(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Re-enter your new password:
function Game_ReEnterYourNewPassword(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
end

-- Username changed from * to *
function Game_UsernameChangedFromTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- Password changed successfully.
function Game_PasswordChangedSuccessfully(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- * floats into the room and comes to a stop in your hand.
function Game_FloatsIntoTheRoomAndComes(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Drink.ogg")
end

-- * flies into the room and lands in your arms.
function Game_FliesIntoTheRoomAndLands(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Food.ogg")
end

-- Letter successfully sent to *
function Game_LetterSuccessfullySentTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Submit.ogg")
end

-- * depart*to modify the game.
function Game_DepartToModifyTheGame(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/GameModificationStart.ogg")
end

-- * finish*modifying the game.
function Game_FinishModifyingTheGame(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/GameModificationStop.ogg")
end

-- A tradesman certificate has been created for you and can be found in your inventory.
function Game_ATradesmanCertificateHasBeenCreated(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Certificate.ogg")
end

-- Only * until Christmas!
function Game_OnlyUntilChristmas(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Christmas.ogg")
end

-- *You were awarded * points for the resolution of report *
function Game_YouWereAwardedPointsForThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/ThankYou.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Points.ogg")
  Note(Trim(string.gsub(line, "*", "")))
end

-- *You have unread personal announcements, displaying them now.*
function Game_YouHaveUnreadPersonalAnnouncementsDisplaying(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/ThankYou.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Misc/NewMail.ogg")
  Note(Trim(string.gsub(line, "*", "")))
end

-- * personally wants to thank you for playing Prometheus! As a token of appreciation, have this!
function Game_PersonallyWantsToThankYouFor(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/ThankYou.ogg")
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/AddCredits.ogg")
end

-- You step into a brilliant beam of light which whisks you back to your home.
function Game_YouStepIntoABrilliantBeam(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/Host"..math.random(1, 10)..".ogg")
end

-- ^Verb programmed\.$
function Game_VerbProgrammed(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/SaveSuccessful.ogg")
end

-- ^Verb not programmed\.$
function Game_VerbNotProgrammed(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/SaveFailed.ogg")
end

-- Event mode is now enabled, which means that OOC channel access is unavailable. We hope you enjoy the event!
function Game_EventModeIsNowEnabledWhich(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Hosts/EventsAdded.ogg")
end

-- *Type a destination name. Leave blank for a full menu, cancel with '@abort' or 'A'*
function Game_TypeADestinationNameLeaveBlank(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Misc/Prompt.ogg")
  CallPlugin("369e8998ba42093fcc9231a2","OnPluginCommandEntered",'btt')
end
