-- Run the pack's real SaveConfig in an empty folder (no Config.txt), as a fresh install would.
local pack, dir = arg[1], arg[2]
package.path = pack .. "/lua/?.lua;" .. pack .. "/lua/?/init.lua;" .. package.path
package.preload["lfs"] = function()
  return { attributes = function(p) local f = io.open(p, "r") if f then f:close() return { mode = "file" } end end,
           currentdir = function() return dir end }
end
Workspace = dir .. "/"
function GetInfo() return dir .. "/" end
function Execute() end function Note() end function Accelerator() end function AcceleratorTo() end
function PlayGlobalSound() end NumpadInit = function() end
require("prometheus.core.config")
local ok, err = pcall(SaveConfig)
print("first save (no Config.txt):", ok and "ok" or err)
local f = io.open(dir .. "/Config.txt", "r")
print("Config.txt created:", f ~= nil)
if f then print("  starts with:", (f:read("*l"))) f:close() end
ok, err = pcall(SaveConfig)
print("second save (Config.txt exists):", ok and "ok" or err)
