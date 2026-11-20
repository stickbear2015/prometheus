-- Channels, communicators, the ship's computer announcements and radio traffic.
-- Trigger functions for worlds/plugins/prometheus/comms.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- [Frequency *] *
function Comms_Frequency(name, line, wildcards)
  Execute("history_add All=[" .. wildcards[1] .. "] " .. wildcards[2])
  Execute("history_add Frequency=[" .. wildcards[1] .. "] " .. wildcards[2])
  CurrentGlobalSound = PlayGlobalSound("General/Channels/Frequency.ogg")
  Note("[" .. wildcards[1] .. "] " .. wildcards[2])
end

-- [* to you]*
function Comms_ToYou(name, line, wildcards)
  Execute("history_add All=[" .. wildcards[1] .. " to you]" .. wildcards[2])
  Execute("history_add Private Communication=[" .. wildcards[1] .. " to you]" .. wildcards[2])
  CurrentGlobalSound = PlayGlobalSound("General/Channels/Private.ogg")
end

-- [You to *]*
function Comms_YouTo(name, line, wildcards)
  Execute("history_add All=[You to " .. wildcards[1] .. "]" .. wildcards[2])
  Execute("history_add Private Communication=[You to " .. wildcards[1] .. "]" .. wildcards[2])
  CurrentGlobalSound = PlayGlobalSound("General/Channels/Private.ogg")
end

-- * "* requesting * clearance*" into a small microphone mounted on the console.
function Comms_RequestingClearanceIntoASmallMicrophone(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/CommChirp1.ogg")
end

-- [Code updates] *
function Comms_CodeUpdates(name, line, wildcards)
  Execute("history_add All=Code Updates: " .. wildcards[1])
  Execute("history_add Code Updates=" .. wildcards[1])
  CurrentGlobalSound = PlayGlobalSound("General/Channels/CodeUpdates.ogg")
end

-- [SECTOR COMMUNICATION] *
function Comms_SectorCommunication(name, line, wildcards)
  Execute("history_add All=[Sector] " .. wildcards[1])
  Execute("history_add Sector=" .. wildcards[1])
  CurrentGlobalSound = PlayGlobalSound("General/Channels/Sector.ogg")
  Note("[Sector] " .. wildcards[1])
end

-- A speaker on the communication console crackles to life, and you hear * transmitting from *, *
function Comms_ASpeakerOnTheCommunicationConsole(name, line, wildcards)
  Execute("history_add All=[Sector] " .. wildcards[2] .. ", " .. wildcards[1] .. " transmits, " .. wildcards[3])
  Execute("history_add Sector=" .. wildcards[2] .. ", " .. wildcards[1] .. " transmits, " .. wildcards[3])
  CurrentGlobalSound = PlayGlobalSound("General/Channels/Sector.ogg")
  Note("[Sector] " .. wildcards[2] .. ", " .. wildcards[1] .. " transmits, " .. wildcards[3])
end

-- * say*into a small microphone mounted on the console.
function Comms_SayIntoASmallMicrophoneMounted(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/CommChirp1.ogg")
end

-- Your * emits a confirmational tone as the private link with * is established.
function Comms_YourEmitsAConfirmationalToneAs(name, line, wildcards)
  Execute("history_add All=" .. line)
  Execute("history_add Private Communication=" .. line)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/LinkConfirmed.ogg")
end

-- You deny * request for a communications link.
function Comms_YouDenyRequestForACommunications(name, line, wildcards)
  Execute("history_add All=" .. line)
  Execute("history_add Private Communication=" .. line)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/LinkDenied.ogg")
end

-- * denies your request.
function Comms_DeniesYourRequest(name, line, wildcards)
  Execute("history_add All=" .. line)
  Execute("history_add Private Communication=" .. line)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/LinkDenied.ogg")
end

-- * has deleted * communications link with you.
function Comms_HasDeletedCommunicationsLinkWithYou(name, line, wildcards)
  Execute("history_add All=" .. line)
  Execute("history_add Private Communication=" .. line)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/LinkConfirmed.ogg")
end

-- You delete your communications link with *.
function Comms_YouDeleteYourCommunicationsLinkWith(name, line, wildcards)
  Execute("history_add All=" .. line)
  Execute("history_add Private Communication=" .. line)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/LinkConfirmed.ogg")
end

-- Your * flashes a message, indicating that the remote link with its starship has been lost due to *.
function Comms_YourFlashesAMessageIndicatingThat(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/LinkConfirmed.ogg")
end

-- The screen of * with * screen and * switches flashes briefly, indicating that a new link to a starship has been established.
function Comms_TheScreenOfWithScreenAnd(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/LinkConfirmed.ogg")
end

-- * private communications are disabled.
function Comms_PrivateCommunicationsAreDisabled(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/Disabled.ogg")
end

-- ^Sorry\, but your command input has been blocked\. We apologize for any inconvenience this may cause you\.$
function Comms_SorryButYourCommandInputHas(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/Disabled.ogg")
end

-- A small speaker on * suddenly emits a loud burst of static.
function Comms_ASmallSpeakerOnSuddenlyEmits(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/Static"..math.random(1, 5)..".ogg")
end

-- * with * suddenly emits a painfully loud burst of static. After a few moments, it subsides a bit, and a synthesized voice breaks through the static, saying: *
function Comms_WithSuddenlyEmitsAPainfullyLoud(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/Static"..math.random(1, 5)..".ogg")
end

-- From a large speaker on *, You hear * say, "*".
function Comms_FromALargeSpeakerOnYou(name, line, wildcards)
  Execute("history_add All=[EXT] " .. wildcards[2] .. " on " .. wildcards[1] .. " says: " .. wildcards[3])
  Execute("history_add PA=[EXT] " .. wildcards[2] .. " on " .. wildcards[1] .. " says: " .. wildcards[3])
  CurrentGlobalSound = PlayGlobalSound("Starship/Comm/PA"..math.random(1, 9)..".ogg")
end

-- You say "*" into an external PA microphone.
function Comms_YouSayIntoAnExternalPa(name, line, wildcards)
  Execute("history_add All=[EXT] You say: " .. wildcards[1])
  Execute("history_add PA=[EXT] You say: " .. wildcards[1])
  CurrentGlobalSound = PlayGlobalSound("Starship/Comm/PA"..math.random(1, 9)..".ogg")
end

-- A voice comes over the speaker and says, "*".
function Comms_AVoiceComesOverTheSpeaker(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/CommChirp2.ogg")
  Note(wildcards[1])
end

-- A voice announces, "*"
function Comms_AVoiceAnnounces(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/CommChirp2.ogg")
  Note(wildcards[1])
end

-- Primary frequency set to *.
function Comms_PrimaryFrequencySetTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/Tune.ogg")
end

-- You notify flight control of your desire to *
function Comms_YouNotifyFlightControlOfYour(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/CommChirp1.ogg")
end

-- You have been added to the owners list of *.
function Comms_YouHaveBeenAddedToThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/LinkConfirmed.ogg")
end

-- You have been added to the recognized fingerprints to the exit * of *.
function Comms_YouHaveBeenAddedToThe2(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/LinkConfirmed.ogg")
end

-- You have been authorized to *.
function Comms_YouHaveBeenAuthorizedTo(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/LinkConfirmed.ogg")
end

-- You have been added to the recognized fingerprints of *.
function Comms_YouHaveBeenAddedToThe3(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/LinkConfirmed.ogg")
end

-- A voice comes from the speaker of *, "*"
function Comms_AVoiceComesFromTheSpeaker(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/CommChirp1.ogg")
  Note(wildcards[2])
end

-- Event mode has been disabled, the hosts hope you enjoyed. OOC channels will be restored.
function Comms_EventModeHasBeenDisabledThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Channels/OOC.ogg")
end

-- The communication beacons are currently unreachable. Unable to start teleportation process...
function Comms_TheCommunicationBeaconsAreCurrentlyUnreachable(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/Disabled.ogg")
end

-- Teleporting is not possible while the starship is unable to connect to the communication beacons.
function Comms_TeleportingIsNotPossibleWhileThe(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/Disabled.ogg")
end

-- That doesn't seem to be working.
function Comms_ThatDoesnSeemToBeWorking(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/Disabled.ogg")
end

-- Out of character channels are currently disabled. They will be back soon!
function Comms_OutOfCharacterChannelsAreCurrently(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/Disabled.ogg")
end
