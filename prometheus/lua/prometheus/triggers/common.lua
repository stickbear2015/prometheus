-- Shared helpers for the trigger functions.

-- Add a message to the All buffer and to one other buffer. The buffers belong to the
-- channel history plugin; this sends it the same two history_add commands the triggers
-- always have, All first.
--   buffer    the other buffer's name, for example "Private Communication"
--   text      what goes in that buffer
--   all_text  what goes in All, if it's different (often text with a label in front)
function AddToHistory(buffer, text, all_text)
  Execute("history_add All=" .. (all_text or text))
  Execute("history_add " .. buffer .. "=" .. text)
end

-- Is this "You" or a character's name? A name is one to four capitalised words (O'Connell
-- and hyphens are fine), optionally followed by "<colour> Designation", as in
-- "Alex Smith blue Designation". Used where a trigger should only react to someone doing
-- something, not to descriptions or speech that happen to contain the same word.
function IsYouOrCharacter(text)
  if text == "You" then
    return true
  end
  local words = {}
  for word in string.gmatch(text, "[^ ]+") do
    words[#words + 1] = word
  end
  if #words >= 3 and words[#words] == "Designation" and string.match(words[#words - 1], "^%l+$") then
    words[#words] = nil
    words[#words] = nil
  end
  if #words < 1 or #words > 4 then
    return false
  end
  for _, word in ipairs(words) do
    if not string.match(word, "^%u[%a'%-]+$") then
      return false
    end
  end
  return true
end

-- Sound lists:
--
-- A sound list is a table of entries, checked from top to bottom. An entry says what
-- text to look for and what to play. Text is looked for with string.match, as the
-- pack always has, so a few characters ( ^ $ . - % and brackets) have special meanings.
--
-- What an entry looks for (all the ones given must be true):
--   has        text (or a list of texts) that must all appear
--   has_lower  the same, but looked for in the lowercased line
--   any        a list of texts, at least one of which must appear
--   any_lower  the same, in the lowercased line
--
-- What an entry plays:
--   sound      the sound file, without the number and .ogg (leave it out to play nothing)
--   versions   how many numbered versions there are (one is picked at random)
--   combat     play it as a combat sound (combat volume and on/off setting)
--   pan        play it at a random position between left and right
--   also       a second sound to play straight after, written the same way
--   play       instead of sound: a function(text) that decides what to play
--   sounds     instead of sound: a smaller list to look the same text up in; the first
--              entry there that fits is played (nothing, if none fits)

local function as_list(v)
  if type(v) == "table" then
    return v
  end
  return { v }
end

-- Does this entry fit the text? (lower is the lowercased text.)
local function entry_fits(entry, text, lower)
  for _, t in ipairs(entry.has and as_list(entry.has) or {}) do
    if not string.match(text, t) then return false end
  end
  for _, t in ipairs(entry.has_lower and as_list(entry.has_lower) or {}) do
    if not string.match(lower, t) then return false end
  end
  if entry.any then
    local found = false
    for _, t in ipairs(entry.any) do
      if string.match(text, t) then found = true break end
    end
    if not found then return false end
  end
  if entry.any_lower then
    local found = false
    for _, t in ipairs(entry.any_lower) do
      if string.match(lower, t) then found = true break end
    end
    if not found then return false end
  end
  return true
end

-- The first entry in the list that fits the text, or nil.
function FindSoundEntry(list, text)
  local lower = string.lower(text)
  for _, entry in ipairs(list) do
    if entry_fits(entry, text, lower) then
      return entry
    end
  end
  return nil
end

-- Play one sound written as { sound = ..., versions = ..., combat = ... }.
function PlaySoundSpec(spec)
  if not spec.sound then
    return
  end
  local file = spec.sound
  if spec.versions then
    file = file .. math.random(1, spec.versions)
  end
  local pan = nil
  if spec.pan then
    pan = math.random(-100, 100)
  end
  if spec.combat then
    CurrentCombatSound = PlayCombatSound(file .. ".ogg", pan)
  else
    CurrentGlobalSound = PlayGlobalSound(file .. ".ogg", pan)
  end
end

-- Play what an entry says to play for this text.
function PlaySoundEntry(entry, text)
  if entry.play then
    entry.play(text)
    return
  end
  if entry.sounds then
    local found = FindSoundEntry(entry.sounds, text)
    if found then
      PlaySoundEntry(found, text)
    end
    return
  end
  PlaySoundSpec(entry)
  if entry.also then
    PlaySoundSpec(entry.also)
  end
end
