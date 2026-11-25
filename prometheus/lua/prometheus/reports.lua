-- Reports from the soundpack (Kendal, 2026-11-25; every message approved by Kendal).
--
--   spreport               send a new report: kind, title, what happened, pasted game output
--                          (bugs), optional email, then a check before sending
--   spreports              your reports: choose one to read it with its replies, then add more
--   spreport add <number>  add more details to one of your reports
--
-- The real work is done by PrometheusUpdater.exe ("report"): it talks to the website, adds the
-- tester code itself, and keeps each stable report's private key, so this file never handles a
-- code or a key. Game output is only ever what the player pastes: the pack never reads the
-- output to build a report.

local ROOT = GetInfo(66)
local UPDATER = ROOT .. "PrometheusUpdater.exe"
local STATE = ROOT .. "worlds\\plugins\\state\\"
local REQUEST = STATE .. "updater-report-request.json"
local RESULT = STATE .. "updater-report.json"
local TITLE = "Prometheus soundpack report"

local KINDS = { bug = "A bug: something is wrong", suggestion = "A suggestion or idea", other = "Something else" }

local Reports = { waiting = false, started = 0, after = nil }

local function read_all(path)
  local f = io.open(path, "rb")
  if not f then return nil end
  local s = f:read("*a")
  f:close()
  return s
end

local function write_all(path, text)
  local f = io.open(path, "wb")
  if not f then return false end
  f:write(text)
  f:close()
  return true
end

-- Shows a message in the output and speaks it (the tts plugin's quotes can't hold " marks).
local function tell(text)
  Note(text)
  Execute("tts_interrupt " .. string.gsub(text, '"', "'"))
end

local function trim(s)
  return (string.gsub(s or "", "^%s+", ""):gsub("%s+$", ""))
end

-- Asks the updater, then calls after(result) with the website's answer, or
-- {status = "unreachable"} if nothing came back.
local function ask(request, after)
  if Reports.waiting then return end
  os.remove(RESULT)
  local json = require("json")
  local f = io.open(UPDATER, "rb")
  if not f then
    tell("The soundpack's updater is missing. Please download the full installer from https://stickbear.me/prometheus.")
    return
  end
  f:close()
  if not write_all(REQUEST, json.encode(request)) then
    after({ status = "unreachable" })
    return
  end
  utils.shellexecute(UPDATER, "report", ROOT, "open", 0)
  Reports.waiting, Reports.started, Reports.after = true, os.time(), after
  AddTimer("ReportsPoll", 0, 0, 0.1, "", timer_flag.Enabled + timer_flag.Replace + timer_flag.Temporary, "Reports_Poll")
end

function Reports_Poll()
  local text = read_all(RESULT)
  local result
  if text then
    os.remove(RESULT)
    local ok, r = pcall(require("json").decode, text)
    result = (ok and type(r) == "table") and r or { status = "unreachable" }
  elseif os.time() - Reports.started > 60 then
    result = { status = "unreachable" }
  else
    return
  end
  DeleteTimer("ReportsPoll")
  local after = Reports.after
  Reports.waiting, Reports.after = false, nil
  if after then after(result) end
end

-- Blocked: say so, and offer to tell Kendal (the updater's appeal, as for spupdate).
local function blocked(result, attempt)
  local say = result.message or "Your connection has been blocked from reports."
  tell(say)
  local answer = utils.msgbox(say .. "\n\nTell Kendal you think this is a mistake?", TITLE, "yesno", "?")
  if answer == "yes" then Updater_Appeal(attempt) end
end

-- Reads out the website's own sentences for problems with what was typed.
local function problems(result)
  local said = false
  if type(result.problems) == "table" then
    for _, sentence in pairs(result.problems) do
      tell(sentence)
      said = true
    end
  end
  if not said and result.message then tell(result.message) end
end

local DEBUG_MISSING = "This game output doesn't have the spdebug lines. In the game, type spdebug, do whatever caused the problem again, then copy the output including the lines that start with [debug]."

local function has_debug(output)
  return string.find("\n" .. output, "\n%s*%[debug%]") ~= nil
end

-- ---------- spreport: a new report ----------

function Reports_Send()
  local kind = utils.listbox("What kind of report is this?", TITLE, KINDS)
  if not kind then return tell("Report not sent.") end
  local title = utils.inputbox("A short title\n\nFor example: No sound when my ship launches torpedoes.", TITLE, "")
  if not title then return tell("Report not sent.") end
  local details = utils.editbox(kind == "bug"
    and "What happened, or your idea\n\nWhat you did, what happened, and what you expected to happen."
    or "What happened, or your idea", TITLE, "")
  if not details then return tell("Report not sent.") end
  local output = ""
  if kind == "bug" then
    output = utils.editbox("Paste the exact game output, including the spdebug lines.", TITLE, "")
    if not output then return tell("Report not sent.") end
    if not has_debug(output) then return tell(DEBUG_MISSING) end
  end
  local email = utils.inputbox("Your email address (optional)\n\nOnly so we can email you your private link and tell you when someone replies. Leave it empty if you'd rather not.", TITLE, "")
  if not email then return tell("Report not sent.") end
  title, details, output, email = trim(title), trim(details), trim(output), trim(email)

  local review = "Kind of report: " .. KINDS[kind] .. "\r\n\r\nTitle: " .. title
    .. "\r\n\r\nWhat happened, or your idea:\r\n" .. details
  if kind == "bug" then review = review .. "\r\n\r\nGame output:\r\n" .. output end
  review = review .. "\r\n\r\nEmail address: " .. (email ~= "" and email or "Not given")
  if not utils.editbox("Check your report", "Check your report", string.gsub(review, "\r?\n", "\r\n"), nil, nil, { read_only = true }) then
    return tell("Report not sent.")
  end
  if utils.msgbox("Send it now?", TITLE, "yesno", "?") ~= "yes" then return tell("Report not sent.") end

  tell("Sending your report.")
  ask({ op = "send", kind = kind, title = title, details = details, game_output = output, email = email }, function(r)
    if r.status == "sent" then
      local label = string.lower(r.label or "")
      if string.find(label, "^tester") then
        tell("Your report is sent: " .. label .. ". You can also find it under Your reports on your testers page.")
      else
        tell("Your report is sent: " .. label .. ". Type spreports to see replies." .. (email ~= "" and " We've emailed you its private link." or ""))
      end
    elseif r.status == "blocked" then
      blocked(r, "pack_report")
    elseif r.status == "problems" or r.message then
      problems(r)
    else
      tell("Your report couldn't be sent just now. Please try again later.")
    end
  end)
end

-- ---------- adding to a report ----------

local function add_to(number, label)
  local text = utils.editbox("What you want to add", TITLE, "")
  if not text then return end
  local more = utils.editbox("More game output (optional)", TITLE, "")
  if not more then return end
  ask({ op = "add", number = number, details = trim(text), game_output = trim(more) }, function(r)
    if r.status == "added" then
      tell("Thank you. Your details are added to " .. string.lower(r.label or label or ("report " .. number)) .. ".")
    elseif r.status == "unknown" then
      tell("You don't have a report with that number in this soundpack.")
    elseif r.status == "blocked" then
      blocked(r, "pack_reply")
    elseif r.status == "closed" or r.status == "problems" or r.message then
      problems(r)
    else
      tell("Your report couldn't be sent just now. Please try again later.")
    end
  end)
end

-- spreport add <number>: check the report is one of yours (and still open) before asking anything.
function Reports_AddAlias(name, line, wildcards)
  local number = tonumber(wildcards[1])
  ask({ op = "read", number = number }, function(r)
    if r.status == "unknown" then return tell("You don't have a report with that number in this soundpack.") end
    if r.status ~= "ok" then return tell("Your reports couldn't be read just now. Please try again later.") end
    if r.closed then
      return tell("This report is closed, so it can't take any more replies. If there's more to say, or something new, please send a new report.")
    end
    add_to(number, r.label)
  end)
end

-- ---------- spreports: your reports ----------

local function show(number)
  ask({ op = "read", number = number }, function(r)
    if r.status == "unknown" then return tell("You don't have a report with that number in this soundpack.") end
    if r.status ~= "ok" then return tell("Your reports couldn't be read just now. Please try again later.") end
    local lines = { "Status: " .. (r.report_status_text or "") .. ". Sent " .. (r.sent_text or "") .. ".", "", r.details or "" }
    if r.game_output and r.game_output ~= "" then
      table.insert(lines, "")
      table.insert(lines, "Game output you sent:")
      table.insert(lines, r.game_output)
    end
    table.insert(lines, "")
    table.insert(lines, "Replies and additions:")
    if type(r.replies) ~= "table" or #r.replies == 0 then
      table.insert(lines, "Nothing yet.")
    else
      for _, x in ipairs(r.replies) do
        table.insert(lines, "")
        table.insert(lines, (x.from == "you" and "You added, " or "Reply from the soundpack team, ") .. (x.at_text or "") .. ":")
        table.insert(lines, x.text or "")
      end
    end
    local heading = (r.label or "") .. ": " .. (r.title or "")
    local text = string.gsub(table.concat(lines, "\n"), "\r?\n", "\r\n")
    utils.editbox(heading, heading, text, nil, nil, { read_only = true })
    if r.closed then
      return tell("This report is closed, so it can't take any more replies. If there's more to say, or something new, please send a new report.")
    end
    if utils.msgbox("Add more details to this report?", TITLE, "yesno", "?") == "yes" then
      add_to(number, r.label)
    end
  end)
end

function Reports_List()
  ask({ op = "list" }, function(r)
    if r.status ~= "ok" or type(r.reports) ~= "table" then
      return tell("Your reports couldn't be read just now. Please try again later.")
    end
    if #r.reports == 0 then return tell("You haven't sent any reports from this soundpack yet.") end
    local choices = {}
    for i, x in ipairs(r.reports) do
      choices[i] = (x.label or "") .. ": " .. (x.title or "") .. " (" .. (x.report_status_text or "") .. ")"
    end
    local i = utils.listbox("Your reports", "Your reports", choices)
    if i then show(r.reports[i].number) end
  end)
end

return Reports
