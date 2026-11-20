-- Trigger test harness: runs the pack's real Lua with a pretend MUSHclient
-- around it, and prints every sound and action as one line each.
-- Usage (normally run by run.py): luajit harness.lua <pack folder> <cases file>
-- Nothing here touches MUSHclient or plays any sound.

local pack = arg[1]
local cases_file = arg[2]

local out = {}
local function emit(...)
  local parts = {}
  for i = 1, select("#", ...) do parts[#parts + 1] = tostring((select(i, ...))) end
  io.write(table.concat(parts, "\t"), "\n")
end

-- Deterministic random numbers: always the lowest value, and record the range,
-- so old and new code are compared on the same choices and ranges.
math.random = function(a, b)
  if a == nil then emit("random") return 0 end
  if b == nil then a, b = 1, a end
  emit("random", a, b)
  return a
end

-- Pretend MUSHclient --------------------------------------------------------
local variables = {}
sendto = { world = 0, command = 1, output = 2, status = 3, notepad = 4, script = 12, scriptafteromit = 14 }
function GetInfo(n)
  if n == 66 then return pack .. "\\" end
  if n == 74 then return pack .. "\\sounds\\" end
  return ""
end
function GetVariable(name) return variables[name] end
function SetVariable(name, value) variables[name] = tostring(value) end
function Execute(s) emit("execute", s) end
function Send(s) emit("send", s) end
function Note(...) emit("note", table.concat({...}, "")) end
function ColourNote(...) local t = {...} local s = {} for i = 3, #t, 3 do s[#s + 1] = t[i] end emit("note", table.concat(s, "")) end
function ColourTell(...) end
function Tell(...) end
function DoAfterSpecial(secs, what, to) emit("doafter", secs, what, to) end
function DoAfter(secs, what) emit("doafter", secs, what) end
function CallPlugin(id, func, ...) emit("callplugin", id, func, ...) return 0 end
function ReloadPlugin(id) emit("reloadplugin", id) end
function GetPluginList() return {} end
function GetPluginInfo() return nil end
function ImportXML() return 0 end
function SetOption(...) end
function GetOption() return 0 end
function Accelerator(...) end
function AcceleratorTo(...) end
function Trim(s) return (tostring(s):gsub("^%s+", ""):gsub("%s+$", "")) end
function tprint() end
function EnableTrigger(name, on) emit("enabletrigger", name, on) end
function EnableTriggerGroup(name, on) emit("enabletriggergroup", name, on) end
function EnableAlias(name, on) emit("enablealias", name, on) end
function SetStatus(s) end
function Sound(f) emit("mushsound", f) end
function PlaySound(...) emit("mushsound", ...) end
utils = {
  shellexecute = function(...) emit("shellexecute", ...) end,
  msgbox = function() return "ok" end,
  split = function(s, sep)
    local t = {}
    for piece in (s .. sep):gmatch("(.-)" .. sep:gsub("%p", "%%%0")) do t[#t + 1] = piece end
    return t
  end,
}
world = setmetatable({}, { __index = function(_, k) return _G[k] end })

-- Fake Audio plugin (normally LuaAudio, loaded through PPI).
local next_id = 10
Audio = {
  play = function(file, loop, pan, vol) next_id = next_id + 1 emit("play", file, loop, pan, vol) return next_id end,
  stop = function(id) emit("stop") return 0 end,
  isPlaying = function() return 1 end,
  setVol = function(vol) emit("setvol", vol) return 0 end,
  setPan = function() return 0 end,
}
package.preload["ppi"] = function() return { Load = function() return Audio end } end

-- lfs is a C module built for MUSHclient's Lua; replace it with a stand-in.
package.preload["lfs"] = function()
  return {
    attributes = function(p, what)
      local f = io.open(p, "r")
      if f then f:close() if what == "mode" then return "file" end return { mode = "file" } end
      return nil
    end,
    currentdir = function() return pack end,
    dir = function() return function() return nil end end,
  }
end

package.path = pack .. "\\lua\\?.lua;" .. pack .. "\\lua\\?\\init.lua;" .. package.path

-- Load the plugin's includes and its own script block, as MUSHclient does.
local spec = dofile(cases_file)
for _, inc in ipairs(spec.includes) do
  local chunk, e = loadstring(inc, "=include")
  if chunk then pcall(chunk) else emit("loaderror", e) end
end
do
  local chunk, e = loadstring(spec.script, "=plugin script")
  if not chunk then emit("loaderror", e) else
    local ok, err = pcall(chunk)
    if not ok then emit("loaderror", err) end
  end
end
-- Settings stay at their defaults (config.lua) for every test.
LoadConfig = function() end
SaveConfig = function() emit("saveconfig") end
local defaults = {}
for k, v in pairs(ConfigTable.Settings) do defaults[k] = v end

-- Real Lua 5.1 (MUSHclient) quietly turns an unknown string escape such as \. into
-- the plain character; LuaJIT refuses it. Do what Lua 5.1 does before compiling.
local valid_escape = { a=1, b=1, f=1, n=1, r=1, t=1, v=1, ["\\"]=1, ['"']=1, ["'"]=1, ["\n"]=1 }
local function lua51_escapes(code)
  local out, i, n = {}, 1, #code
  while i <= n do
    local c = code:sub(i, i)
    if c == "\\" and i < n then
      local d = code:sub(i + 1, i + 1)
      if valid_escape[d] or d:match("%d") then out[#out + 1] = c .. d else out[#out + 1] = d end
      i = i + 2
    else
      out[#out + 1] = c
      i = i + 1
    end
  end
  return table.concat(out)
end

-- Run the cases -----------------------------------------------------------
for _, case in ipairs(spec.cases) do
  for k, v in pairs(defaults) do ConfigTable.Settings[k] = v end
  for k, v in pairs(case.settings or {}) do ConfigTable.Settings[k] = v end
  emit("case", case.id)
  for _, f in ipairs(case.fires) do
    emit("fire", f.label)
    if f.omit then emit("omit") end
    local okrun, e
    if f.kind == "send" then
      local chunk, cerr = loadstring(lua51_escapes(f.code), "=" .. f.label)
      if not chunk then
        emit("compileerror", (cerr:gsub("\n", " ")))
      else
        okrun, e = pcall(chunk)
        if not okrun then emit("runerror", (tostring(e):gsub("\n", " "))) end
      end
    elseif f.kind == "script" then
      local fn = _G[f.func]
      if type(fn) ~= "function" then
        emit("missingscript", f.func)
      else
        okrun, e = pcall(fn, f.name, f.line, f.wildcards)
        if not okrun then emit("runerror", (tostring(e):gsub("\n", " "))) end
      end
    elseif f.kind == "world" then
      emit("send", f.code)
    end
  end
end
