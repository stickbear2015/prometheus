-- The soundpack's side of the updater (issue #14). The real work is done by
-- PrometheusUpdater.exe, next to mushclient.exe (its source is in its own private repo):
-- it checks the website, checks the signature and every file, and changes the files. This
-- file only starts it, reads what it writes in worlds\plugins\state, tells the player, and
-- reloads the plugins afterwards.
--
--   spupdate             check now; if there's an update, ask whether to install it
--   sptester             ask for a tester code (a dialog)
--   sptester <code>      set the tester code
--   sptester off         stop being a tester, and offer the stable version
--   sptester status      whether a code is set, and which channel (never the code itself)
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
  poll_every(0.5)
end

local function checked(result)
  if result.status == "update" and result.repair then
    -- Files changed outside the soundpack (edited pack files, or a world file with the player's
    -- own aliases, triggers, timers or variables) are put back without asking, before anything
    -- else, so nobody can keep them just by never typing spupdate (Shane, 2026-11-23).
    local what = "Some of the soundpack's own files were changed outside the soundpack, and they have to be put back before you can carry on."
    if result.world_reset and #(result.edited or {}) == 0 then
      what = "Your world file has aliases, triggers, timers or variables of your own, and it has to be reset to the soundpack's own before you can carry on. Your plugins and login details are kept."
    elseif #(result.edited or {}) > 0 then
      what = what .. " Changed: " .. table.concat(result.edited, ", ") .. "."
    end
    if result.needs_close then
      what = what .. " MUSHclient will close and start again by itself."
    else
      what = what .. " They're being put back now."
    end
    tell(what)
    utils.msgbox(what, "Prometheus soundpack", "ok", "!")
    Updater_Install(result.needs_close)  elseif result.status == "update" then
    tell(result.say)
    local answer = utils.msgbox(result.say .. "\n\nInstall it now?", "Prometheus soundpack update", "yesno", "?")
    if answer == "yes" then
      Updater_Install()
    else
      tell("Not installed. Type spupdate whenever you want it.")
    end
  elseif result.status == "problem" then
    if not Updater.quiet then tell(result.say) end
  else
    -- Up to date. Still say so if a tester code was just dropped.
    if not Updater.quiet or result.code_dropped then tell(result.say) end
  end
end

-- ---------- installing ----------

-- forced: a world file reset, which closes MUSHclient by itself instead of asking the player to.
function Updater_Install(forced)
  Updater.forced = forced and true or false
  os.remove(PROGRESS_FILE)
  if not start_updater("install") then return end
  Updater.waiting, Updater.progress_seen, Updater.started = "install", 0, os.time()
  if not Updater.forced then tell("Installing the soundpack update.") end
  poll_every(0.5)
end

-- Reloads the pack's plugins after an update. Other plugins first; this one last, a moment
-- later, because a plugin can't reload itself while its own code is running.
local function reload_plugins()
  local me = GetPluginID()
  for _, id in ipairs(GetPluginList() or {}) do
    if id ~= me then ReloadPlugin(id) end
  end
  DoAfterSpecial(1, 'ReloadPlugin("' .. me .. '")', sendto.script)
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
local function send_code(code)
  local socket = require("socket")
  os.remove(PORT_FILE)
  if not start_updater("set-code") then return end
  local port
  for _ = 1, 50 do
    local p = read_all(PORT_FILE)
    if p and tonumber(p) then port = tonumber(p) break end
    socket.sleep(0.1)
  end
  if not port then
    tell("The updater didn't start, so the tester code wasn't set. Type sptester again.")
    return
  end
  local conn = socket.tcp()
  conn:settimeout(5)
  local ok = conn:connect("127.0.0.1", port)
  if not ok then
    conn:close()
    tell("Couldn't reach the updater, so the tester code wasn't set. Type sptester again.")
    return
  end
  conn:send(code .. "\n")
  local reply = conn:receive("*l") or ""
  conn:close()
  if reply == "ok" then
    tell("Tester code saved. Checking for test versions.")
    Updater_Check(false)
  else
    tell((string.gsub(reply, "^error ", "")))
  end
end

function Updater_Tester(arg)
  arg = string.match(arg or "", "^%s*(.-)%s*$")
  local lower = string.lower(arg)
  if lower == "status" then
    if exists(CODE_FILE) then
      tell("A tester code is set, so the soundpack checks for test versions.")
    else
      tell("No tester code is set, so the soundpack checks for stable versions. Type sptester to enter one.")
    end
  elseif lower == "off" then
    start_updater("clear-code")
    tell("Tester code removed. Checking for the stable version.")
    DoAfterSpecial(2, "Updater_Check(false)", sendto.script)
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

return Updater
