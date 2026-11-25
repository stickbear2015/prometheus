-- The soundpack's side of the updater (issue #14). The real work is done by
-- PrometheusUpdater.exe, next to mushclient.exe (its source is in its own private repo):
-- it checks the website, checks the signature and every file, and changes the files. This
-- file only starts it, reads what it writes in worlds\plugins\state, tells the player, and
-- reloads the plugins afterwards.
--
--   spupdate             check now; if there's an update, ask whether to install it
--   sptester             ask for a tester code (a dialog)
--   sptester <code>      set the tester code
--   sptester off         stop being a tester, and offer the stable version (after two warnings)
--   sptester status      whether a code is set, and which channel (never the code itself)
--
-- What these commands say, and the warnings before taking a code off, are written by the
-- updater; this file shows them.
--
-- The pack also checks quietly when you connect, and only speaks up if there's something to
-- install. The tester code goes to the updater over a private connection on this PC only, and
-- is kept encrypted by Windows; this file never stores it.

-- socket and json are loaded only when needed, so starting the pack never depends on them.

local ROOT = GetInfo(66)                                    -- the MUSHclient folder, with a \ at the end
local UPDATER = ROOT .. "PrometheusUpdater.exe"
local STATE = ROOT .. "worlds\\plugins\\state\\"
local CHECK_FILE = STATE .. "updater-check.json"
local PROGRESS_FILE = STATE .. "updater-progress.txt"
local PORT_FILE = STATE .. "updater-port.txt"
local CODE_FILE = STATE .. "updater-tester.dat"
local APPEAL_FILE = STATE .. "updater-appeal.json"
local WORDS_FILE = STATE .. "updater-words.json"

local Updater = { waiting = nil, progress_seen = 0, started = 0, quiet = false, forced = false }

local function exists(path)
  local f = io.open(path, "rb")
  if f then f:close() return true end
  return false
end

local function read_all(path)
  local f = io.open(path, "rb")
  if not f then return nil end
  local s = f:read("*a")
  f:close()
  return s
end

-- Shows a message in the output and speaks it (the tts plugin's quotes can't hold " marks).
local function tell(text)
  text = string.gsub(text, '"', "'")
  Note(text)
  Execute("tts_interrupt " .. text)
end

-- When an update had to close MUSHclient, the updater finishes, starts MUSHclient again and
-- leaves its result here; the pack reads it out once it has loaded, then deletes it.
local RESULT_FILE = STATE .. "updater-result.txt"
function Updater_StartupReport()
  local f = io.open(RESULT_FILE, "rb")
  if not f then return end
  local text = f:read("*a") or ""
  f:close()
  os.remove(RESULT_FILE)
  if text ~= "" then tell(text) end
end

local function start_updater(command)
  if not exists(UPDATER) then
    tell("The soundpack's updater is missing. Please download the full installer from https://stickbear.me/prometheus.")
    return false
  end
  -- 0: no window. The updater has none anyway; it only shows a message box when MUSHclient
  -- has to close.
  utils.shellexecute(UPDATER, command, ROOT, "open", 0)
  return true
end

-- How often the updater's files are read while it works (Kendal, 2026-11-24: faster updates).
-- MUSHclient's timers tick every 0.1 seconds by default, and reading a small file is cheap.
local POLL_SECONDS = 0.1

local function poll_every(seconds)
  AddTimer("UpdaterPoll", 0, 0, seconds, "", timer_flag.Enabled + timer_flag.Replace + timer_flag.Temporary, "Updater_Poll")
end

local function stop_polling()
  DeleteTimer("UpdaterPoll")
  Updater.waiting = nil
end

-- ---------- checking ----------

-- quiet: the check when connecting, which says nothing unless there's something to install.
function Updater_Check(quiet)
  if Updater.waiting then return end
  os.remove(CHECK_FILE)
  if not start_updater("check") then return end
  Updater.waiting, Updater.quiet, Updater.started = "check", quiet, os.time()
  if not quiet then tell("Checking for soundpack updates.") end
  poll_every(POLL_SECONDS)
end

local function checked(result)
  if result.status == "update" and result.repair then
    -- Files changed outside the soundpack (edited pack files, or a world file with the player's
    -- own aliases, triggers, timers or variables) are put back without asking, before anything
    -- else, so nobody can keep them just by never typing spupdate (Kendal, 2026-11-23).
    -- The updater writes the words (Kendal, 2026-11-23): edited files, with the reminder about the
    -- game's policies, and missing files, never naming which; and whether MUSHclient will restart.
    -- There's no choice: the box only has OK, and the repair starts when it's closed.
    local what = result.say
    tell(what)
    utils.msgbox(what, "Prometheus soundpack", "ok", "!")
    -- A repair always closes MUSHclient by itself when it has to (a world file reset, or a program
    -- file), rather than asking the player to.
    Updater_Install(true)
  elseif result.status == "update" and type(result.choices) == "table" and #result.choices > 0 then
    -- The updater can send a list of choices instead of Yes/No, with its own words. The chosen
    -- key goes back to it; "later", or closing the list, installs nothing.
    tell(result.say)
    local list = {}
    for _, c in ipairs(result.choices) do list[c.key] = c.text end
    local key = utils.listbox(result.say, result.choices_title or "Prometheus soundpack update", list)
    if key and key ~= "later" then
      Updater_Install(false, key)
    else
      tell("Not installed. Type spupdate whenever you want it.")
    end
  elseif result.status == "update" then
    tell(result.say)
    local answer = utils.msgbox(result.say .. "\n\nInstall it now?", "Prometheus soundpack update", "yesno", "?")
    if answer == "yes" then
      Updater_Install()
    else
      tell("Not installed. Type spupdate whenever you want it.")
    end
  elseif result.status == "paused" then
    -- Updates are paused until something is done (the updater says what). Said even at the
    -- quiet check when connecting.
    tell(result.say)
  elseif result.status == "blocked" then
    -- This connection is blocked from updates (Kendal, 2026-11-24). The check at login says
    -- nothing; spupdate says so and offers to tell Kendal, with no typing.
    if not Updater.quiet then
      tell(result.say)
      local answer = utils.msgbox(result.say .. "\n\nTell Kendal you think this is a mistake?", "Prometheus soundpack", "yesno", "?")
      if answer == "yes" then Updater_Appeal("update_check") end
    end
  elseif result.status == "problem" then
    if not Updater.quiet then tell(result.say) end
  else
    -- Up to date. Still say so if a tester code was just dropped.
    if not Updater.quiet or result.code_dropped then tell(result.say) end
  end
end

-- ---------- telling Kendal a block is a mistake ----------

-- attempt: what was blocked (update_check now; pack_report and pack_reply when the report
-- commands come). The updater sends it, and the tester code if there is one, to the website.
function Updater_Appeal(attempt)
  if Updater.waiting then return end
  os.remove(APPEAL_FILE)
  if not start_updater("appeal " .. attempt) then return end
  Updater.waiting, Updater.started = "appeal", os.time()
  poll_every(POLL_SECONDS)
end

-- ---------- installing ----------

-- forced: a repair, which closes MUSHclient by itself (when it has to) instead of asking the player to.
-- mode: a choice the updater offered (passed back to it as it is), or nil.
function Updater_Install(forced, mode)
  Updater.forced = forced and true or false
  os.remove(PROGRESS_FILE)
  local command = "install"
  if mode and mode ~= "install" and string.match(mode, "^%a+$") then command = "install " .. mode end
  if not start_updater(command) then return end
  Updater.waiting, Updater.progress_seen, Updater.started = "install", 0, os.time()
  if not Updater.forced then tell("Installing the soundpack update.") end
  poll_every(POLL_SECONDS)
end

-- Reloads the pack's plugins after an update. Other plugins first; then this one, which
-- MUSHclient never lets a plugin do to itself (not even from its own timer), so LuaAudio does it
-- a moment later. Until then, the connection to the reloaded LuaAudio is renewed, so sounds
-- keep working even if the reload can't happen (an older LuaAudio without ReloadPluginSoon).
local LUAAUDIO = "aedf0cb0be5bf045860d54b7"
local function reload_plugins()
  local me = GetPluginID()
  for _, id in ipairs(GetPluginList() or {}) do
    if id ~= me then ReloadPlugin(id) end
  end
  Audio = PPI.Load(LUAAUDIO) or Audio
  if CallPlugin(LUAAUDIO, "ReloadPluginSoon", me) ~= error_code.eOK then
    tell("The soundpack's files were updated, but the soundpack couldn't reload itself. Please close MUSHclient and open it again.")
  end
end

local function read_progress()
  local text = read_all(PROGRESS_FILE)
  if not text then return {} end
  local lines, n = {}, 0
  for line in string.gmatch(text, "[^\r\n]+") do
    n = n + 1
    if n > Updater.progress_seen then table.insert(lines, line) end
  end
  Updater.progress_seen = n
  return lines
end

local function progressed(lines)
  local spoken = {}
  local finished, reload, close = false, false, nil
  for _, line in ipairs(lines) do
    local kind, text = string.match(line, "^(%a+)|(.*)$")
    if kind == "reload" then
      reload = true
    elseif kind then
      if text ~= "" then
        Note(text)
        table.insert(spoken, text)
      end
      if kind == "done" or kind == "error" then finished = true end
      if kind == "close" then close = text end
    end
  end
  if #spoken > 0 then Execute("tts_interrupt " .. string.gsub(table.concat(spoken, " "), '"', "'")) end
  if close and Updater.forced then
    -- A world file reset: save the world (so MUSHclient doesn't stop to ask), then close.
    -- The updater waits for it, rebuilds the world file and starts MUSHclient again.
    stop_polling()
    tell("Closing MUSHclient now. It will start again by itself in a moment.")
    DoAfterSpecial(3, 'DoCommand("Save") DoCommand("ExitClient")', sendto.script)
  elseif close then
    -- The rest needs MUSHclient closed; the updater waits, finishes and starts it again.
    stop_polling()
    utils.msgbox(close, "Prometheus soundpack update", "ok", "i")
  elseif finished then
    stop_polling()
    if reload then reload_plugins() end
  end
end

-- The timer: reads what the updater has written so far.
function Updater_Poll()
  if Updater.waiting == "check" then
    local text = read_all(CHECK_FILE)
    if text then
      stop_polling()
      local json = require("json")
      local ok, result = pcall(json.decode, text)
      if ok and type(result) == "table" then checked(result) end
    elseif os.time() - Updater.started > 90 then
      stop_polling()
      if not Updater.quiet then tell("The update check didn't finish. Please try again later.") end
    end
  elseif Updater.waiting == "appeal" then
    local text = read_all(APPEAL_FILE)
    if text then
      stop_polling()
      os.remove(APPEAL_FILE)
      local json = require("json")
      local ok, result = pcall(json.decode, text)
      if ok and type(result) == "table" and result.say and result.say ~= "" then
        tell(result.say)
      else
        tell("Kendal couldn't be told just now. Please try again later.")
      end
    elseif os.time() - Updater.started > 60 then
      stop_polling()
      tell("Kendal couldn't be told just now. Please try again later.")
    end
  elseif Updater.waiting == "words" then
    local text = read_all(WORDS_FILE)
    if text then
      stop_polling()
      os.remove(WORDS_FILE)
      local json = require("json")
      local ok, result = pcall(json.decode, text)
      if ok and type(result) == "table" then Updater_Said(result) end
    elseif os.time() - Updater.started > 30 then
      stop_polling()
      tell("The updater didn't answer. Please try again.")
    end
  elseif Updater.waiting == "install" then
    progressed(read_progress())
    if Updater.waiting and os.time() - Updater.started > 1800 then
      stop_polling()
      tell("The update is taking a long time. If nothing happens, type spupdate again.")
    end
  else
    stop_polling()
  end
end

-- ---------- tester codes ----------

-- Hands the code to the updater over a private connection on this PC (127.0.0.1): the updater
-- writes the port it's listening on, and the code is sent there. It never goes on disk here.
-- ---------- what the updater says about the codes ----------

-- Asks the updater for its words on a topic (a status, or the warnings before taking a code off).
-- clear: the updater command that takes the code off, run only after Yes in every warning box.
function Updater_Words(topic, clear)
  if Updater.waiting then return end
  os.remove(WORDS_FILE)
  if not start_updater("words " .. topic) then return end
  Updater.waiting, Updater.started, Updater.clear = "words", os.time(), clear
  poll_every(POLL_SECONDS)
end

-- Shows the updater's words: a sentence, or warning boxes (No is the default in each, so Enter
-- does nothing by accident) and then what was done.
function Updater_Said(result)
  if type(result.boxes) ~= "table" then
    if result.say and result.say ~= "" then tell(result.say) end
    return
  end
  for _, box in ipairs(result.boxes) do
    tell(box.text)
    if utils.msgbox(box.text, box.title or "Prometheus soundpack", "yesno", "?", 2) ~= "yes" then
      tell(result.no or "Nothing changed.")
      return
    end
  end
  if Updater.clear then
    start_updater(Updater.clear)
    tell(result.yes or "Done.")
    DoAfterSpecial(2, "Updater_Check(false)", sendto.script)
  end
end

-- second: the second code (spworkbench) instead of the tester code.
local function send_code(code, second)
  local socket = require("socket")
  local again = second and "spworkbench" or "sptester"
  os.remove(PORT_FILE)
  if not start_updater(second and "set-code workbench" or "set-code") then return end
  local port
  for _ = 1, 50 do
    local p = read_all(PORT_FILE)
    if p and tonumber(p) then port = tonumber(p) break end
    socket.sleep(0.1)
  end
  if not port then
    tell("The updater didn't start, so the code wasn't set. Type " .. again .. " again.")
    return
  end
  local conn = socket.tcp()
  conn:settimeout(5)
  local ok = conn:connect("127.0.0.1", port)
  if not ok then
    conn:close()
    tell("Couldn't reach the updater, so the code wasn't set. Type " .. again .. " again.")
    return
  end
  conn:send(code .. "\n")
  local reply = conn:receive("*l") or ""
  conn:close()
  if reply == "ok" then
    tell("Tester code saved. Checking for test versions.")
    Updater_Check(false)
  elseif string.match(reply, "^ok ") then
    -- The updater's own words for this code.
    tell(string.sub(reply, 4))
    Updater_Check(false)
  else
    tell((string.gsub(reply, "^error ", "")))
  end
end

function Updater_Tester(arg)
  arg = string.match(arg or "", "^%s*(.-)%s*$")
  local lower = string.lower(arg)
  if lower == "status" then
    Updater_Words("tester-status")
  elseif lower == "off" then
    Updater_Words("tester-off", "clear-code")
  elseif arg == "" then
    local code = utils.inputbox("Type the tester code Kendal gave you.", "Prometheus tester code", "")
    if code and string.match(code, "%S") then
      send_code(string.match(code, "^%s*(.-)%s*$"))
    end
  else
    send_code(arg)
  end
end

-- The sptester alias (a script, so whatever is typed after it can't break anything, and it's
-- kept out of the command history, the log and the output).
function Updater_TesterAlias(name, line, wildcards)
  Updater_Tester(wildcards[1] or "")
end

-- A second code, handled the same way: status and off through the updater's words.
function Updater_Workbench(arg)
  arg = string.match(arg or "", "^%s*(.-)%s*$")
  local lower = string.lower(arg)
  if lower == "status" then
    Updater_Words("workbench-status")
  elseif lower == "off" then
    Updater_Words("workbench-off", "clear-code workbench")
  elseif arg == "" then
    local code = utils.inputbox("Type the developer code Kendal gave you.", "Prometheus developer code", "")
    if code and string.match(code, "%S") then
      send_code(string.match(code, "^%s*(.-)%s*$"), true)
    end
  else
    send_code(arg, true)
  end
end

function Updater_WorkbenchAlias(name, line, wildcards)
  Updater_Workbench(wildcards[1] or "")
end

return Updater
