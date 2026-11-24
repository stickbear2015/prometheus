-- First open of a fresh copy: OnPluginInstall with no Config.txt, then connect and disconnect.
local pack, dir = arg[1], arg[2]
package.path = pack .. "/lua/?.lua;" .. pack .. "/lua/?/init.lua;" .. package.path
package.preload["lfs"] = function()
  return { attributes = function(p, what) local f = io.open(p, "r") if f then f:close() if what == "mode" then return "file" end return { mode = "file" } end end,
           currentdir = function() return dir end }
end
Workspace = dir .. "/"
function GetInfo() return dir .. "/" end
function GetVariable() return "test" end
function Execute() end function Note() end function Accelerator() end function AcceleratorTo() end
function SetOption() end
sendto = { script = 12 } function DoAfterSpecial(s, what) print("  later (" .. s .. " s):", what) return 0 end
function PlayGlobalSound() return 1 end function StopSound() end
utils = { msgbox = function(msg) print("  message box:", msg) return "ok" end }
NumpadInit = function() end
require("prometheus.core.config")
require("prometheus.core.plugin")
for _, step in ipairs({ "OnPluginInstall", "OnPluginConnect", "OnPluginDisconnect", "OnPluginClose" }) do
  local ok, err = pcall(_G[step])
  print(step .. ":", ok and "ok" or err)
end
print("Config.txt created:", io.open(dir .. "/Config.txt", "r") ~= nil)
