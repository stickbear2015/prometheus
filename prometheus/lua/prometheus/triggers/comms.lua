-- Channels, communicators, the ship's computer announcements and radio traffic.
-- Trigger functions for worlds/plugins/prometheus/comms.xml.
-- Each one receives the trigger's name, the whole line, and the wildcards
-- (the parts of the line the trigger's * or (...) matched).

-- [Frequency *] *
function Comms_Frequency(name, line, wildcards)
  AddToHistory("Frequency", "[" .. wildcards[1] .. "] " .. wildcards[2])
  CurrentGlobalSound = PlayGlobalSound("General/Channels/Frequency.ogg")
  Note("[" .. wildcards[1] .. "] " .. wildcards[2])
end

-- [* to you]*
function Comms_ToYou(name, line, wildcards)
  AddToHistory("Private Communication", "[" .. wildcards[1] .. " to you]" .. wildcards[2])
  CurrentGlobalSound = PlayGlobalSound("General/Channels/Private.ogg")
end

-- [You to *]*
function Comms_YouTo(name, line, wildcards)
  AddToHistory("Private Communication", "[You to " .. wildcards[1] .. "]" .. wildcards[2])
  CurrentGlobalSound = PlayGlobalSound("General/Channels/Private.ogg")
end

-- * "* requesting * clearance*" into a small microphone mounted on the console.
function Comms_RequestingClearanceIntoASmallMicrophone(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/CommChirp1.ogg")
end

-- [Code updates] *
function Comms_CodeUpdates(name, line, wildcards)
  AddToHistory("Code Updates", wildcards[1], "Code Updates: " .. wildcards[1])
  CurrentGlobalSound = PlayGlobalSound("General/Channels/CodeUpdates.ogg")
end

-- [SECTOR COMMUNICATION] *
function Comms_SectorCommunication(name, line, wildcards)
  AddToHistory("Sector", wildcards[1], "[Sector] " .. wildcards[1])
  CurrentGlobalSound = PlayGlobalSound("General/Channels/Sector.ogg")
  Note("[Sector] " .. wildcards[1])
end

-- A speaker on the communication console crackles to life, and you hear * transmitting from *, *
function Comms_ASpeakerOnTheCommunicationConsole(name, line, wildcards)
  AddToHistory("Sector", wildcards[2] .. ", " .. wildcards[1] .. " transmits, " .. wildcards[3], "[Sector] " .. wildcards[2] .. ", " .. wildcards[1] .. " transmits, " .. wildcards[3])
  CurrentGlobalSound = PlayGlobalSound("General/Channels/Sector.ogg")
  Note("[Sector] " .. wildcards[2] .. ", " .. wildcards[1] .. " transmits, " .. wildcards[3])
end

-- * say*into a small microphone mounted on the console.
function Comms_SayIntoASmallMicrophoneMounted(name, line, wildcards)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/CommChirp1.ogg")
end

-- Your * emits a confirmational tone as the private link with * is established.
function Comms_YourEmitsAConfirmationalToneAs(name, line, wildcards)
  AddToHistory("Private Communication", line)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/LinkConfirmed.ogg")
end

-- You deny * request for a communications link.
function Comms_YouDenyRequestForACommunications(name, line, wildcards)
  AddToHistory("Private Communication", line)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/LinkDenied.ogg")
end

-- * denies your request.
function Comms_DeniesYourRequest(name, line, wildcards)
  AddToHistory("Private Communication", line)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/LinkDenied.ogg")
end

-- * has deleted * communications link with you.
function Comms_HasDeletedCommunicationsLinkWithYou(name, line, wildcards)
  AddToHistory("Private Communication", line)
  CurrentGlobalSound = PlayGlobalSound("General/Comm/LinkConfirmed.ogg")
end

-- You delete your communications link with *.
function Comms_YouDeleteYourCommunicationsLinkWith(name, line, wildcards)
  AddToHistory("Private Communication", line)
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
  AddToHistory("PA", "[EXT] " .. wildcards[2] .. " on " .. wildcards[1] .. " says: " .. wildcards[3])
  CurrentGlobalSound = PlayGlobalSound("Starship/Comm/PA"..math.random(1, 9)..".ogg")
end

-- You say "*" into an external PA microphone.
function Comms_YouSayIntoAnExternalPa(name, line, wildcards)
  AddToHistory("PA", "[EXT] You say: " .. wildcards[1])
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

-- Channel messages: [Channel] message, [Channel], "message" and so on.
-- (See common.lua for what each field in these lists means.)

-- Commpipe messages that the Commpipe harvest filter hides completely (no sound, not shown,
-- not added to the buffers) while the filter is on.
COMMPIPE_HARVEST_FILTER = {
  "has been salvaged", "has been harvested", "harvested", "successfully grabbed",
  "Valuable material found", "No minerals detected",
}

-- Flight control messages; the first entry that fits is played.
FLIGHT_CONTROL_SOUNDS = {
  { has = "static", sound = "General/Comm/Static", versions = 5 },
  { has_lower = "ground on", sound = "Ground/GroundTroops", combat = true },
  { has_lower = "enemies are forcing a landing", sound = "General/Comm/FlightControlForcedLanding" },
  { has = "Forced landing at", sound = "General/Comm/FlightControlForcedLanding" },
  { has = { "Detecting", "Repeat" }, sound = "General/Comm/FlightControlEnemiesEntering" },
  { has = "inbound enemy", sound = "General/Comm/FlightControlEnemiesEntering" },
  { has = "retreating", sound = "General/Comm/FlightControlEnemiesRetreating" },
  -- Another ship destroyed (but not an X-Loritan one).
  { has = "destroyed", play = function(text)
      if not string.match(text, "X-Loritan") then
        CurrentGlobalSound = PlayGlobalSound("Combat/Space/OtherDestroyed" .. math.random(1, 8) .. ".ogg")
      end
    end },
}

-- What a ship on Commpipe can report detecting in the sector. Every entry that fits is
-- played. (The same as SECTOR_DETECTIONS in starship.lua, plus the flying cherub.)
COMMPIPE_DETECTIONS = {
  { has = "enemy starship", sound = "Starship/Computer/EnemyDetected" },
  { has = "flying cherub", sound = "Starship/Computer/flyingCherub" },
  { has = "artifact", sound = "Starship/Computer/Artifact" },
  { has = "friendly", sound = "Starship/Computer/FriendlyShip" },
  { has = " relic", sound = "Starship/Computer/Relic" },
  { has = "comet", sound = "Starship/Computer/Comet" },
  { has = "shipwreck", sound = "Starship/Computer/Shipwreck" },
  { has = "planet", sound = "Starship/Computer/Planet" },
  { has = "spacestation", sound = "Starship/Computer/SpaceStation" },
  { has_lower = " star ", sound = "Starship/Computer/Star" },
  { has = "derelict starship", sound = "Starship/Derelicts/AlienStarship" },
  { has = "asteroid", sound = "Starship/Computer/Asteroid" },
  { has = "debris", sound = "Starship/Computer/Debris" },
  { has = "spacebear", sound = "Starship/Computer/Spacebear" },
}

-- Commpipe messages (from your vehicles and ships); the first entry that fits is played.
COMMPIPE_SOUNDS = {
  { any = { "has been salvaged", "has been harvested", "successfully grabbed", "Valuable material found", "No minerals detected" },
    play = function(text)
      if ConfigTable.Settings.SalvagingMessages == 0 and string.match(text, "prepared for future use") then
        CurrentGlobalSound = PlayGlobalSound("Starship/Misc/Prepared.ogg")
      end
    end },
  { has = "detected in the sector", play = function(text)
      for _, entry in ipairs(COMMPIPE_DETECTIONS) do
        if FindSoundEntry({ entry }, text) then PlaySoundEntry(entry, text) end
      end
    end },
  { has = "Powering down due to lack of charge", sound = "Starship/Computer/LowCharge", versions = 2 },
  { has = "Shutting down due to low power conditions", sound = "Starship/Computer/LowCharge", versions = 2 },
  { has = "Beam locked", sound = "Starship/Computer/Warning" },
  { has = "The beam stops abruptly", sound = "Starship/Computer/Warning" },
  { has = "Excavation cannot continue due to the equipment being damaged", sound = "Starship/Computer/Warning" },
}

-- Who logs in and out, on the Info channel.
INFO_SOUNDS = {
  { has = "entered the game", sound = "General/Misc/LoggedOn" },
  { has = "left the game", sound = "General/Misc/LoggedOff" },
}

-- Extra sounds for particular channels, after the channel's own sound. Checked from top to
-- bottom; the first entry whose channel (and message, if given) fits is used.
--   channel / channel_lower   text to look for in the channel's name (lower: lowercased)
--   message                   text that must also be in the message
--   sounds                    a list to look the message up in (see above and common.lua)
--   sound, versions, also     a sound to play, as in common.lua
CHANNEL_SOUNDS = {
  -- "%-" is a plain hyphen ("-" on its own is special in Lua patterns).
  { channel = "OOC", message = "A pre%-recorded message", sound = "General/Hosts/Announcement" },
  { channel = "General", message = "UTF Communications Officer", sound = "General/Misc/Alarm" },
  { channel_lower = "info", sounds = INFO_SOUNDS },
  { channel_lower = "flight control", sounds = FLIGHT_CONTROL_SOUNDS },
  { channel = "Commpipe", sounds = COMMPIPE_SOUNDS },
  { channel_lower = "ship construction", sound = "General/Comm/Notify", also = { sound = "General/Misc/NewsFlash" } },
  { channel_lower = "events", sounds = { { has = "added", sound = "General/Hosts/EventsAdded" } } },  -- no such file yet
  { channel = "PA", sound = "Starship/Comm/PA", versions = 9 },
}

-- ^\[([A-Za-z- ]+)\][,:]? ["]?(.*)["]?$
-- wildcards: 1 = the channel's name, 2 = the message
function Comms_ChannelMessage(name, line, wildcards)
  local channel, message = wildcards[1], wildcards[2]

  -- The Commpipe harvest filter hides harvesting and salvaging reports completely.
  if ConfigTable.Settings.CommpipeHarvestFilter == 1 and string.match(channel, "Commpipe") then
    for _, text in ipairs(COMMPIPE_HARVEST_FILTER) do
      if string.match(message, text) then
        return
      end
    end
  end

  Note(line)
  if tonumber(channel) then
    return  -- a number in brackets, not a channel
  end
  if string.len(channel) > 1 then
    Execute("history_add All=" .. line)
    Execute("history_add " .. prometheus.util.Explode(channel, "-")[1] .. "=" .. message)
  end
  CurrentGlobalSound = PlayGlobalSound("General/Channels/" .. channel .. ".ogg")

  local lower_channel = string.lower(channel)
  for _, entry in ipairs(CHANNEL_SOUNDS) do
    local fits = (not entry.channel or string.match(channel, entry.channel))
      and (not entry.channel_lower or string.match(lower_channel, entry.channel_lower))
      and (not entry.message or string.match(message, entry.message))
    if fits then
      PlaySoundEntry(entry, message)
      return
    end
  end
end
