-- Author; Rafael Natan
-- Description: some helper functions to run the soundpack.
module("prometheus.util",package.seeall)
function GetPluginId(name)
  local ret=nil
  if GetPluginList() then
    for _, id in pairs (GetPluginList()) do 
      if GetPluginInfo(id, 1) == name then
        ret = id
      end
    end
  end
  return ret
end

function Capitalize(str)
  if (str == nil) then
    return
  end
  return (str:gsub("^%l", string.upper))
end

function Trim(str)
  if (str == nil) then
    return
  end
  return (str:gsub("^%s*(.-)%s*$", "%1"))
end

function Explode(str, sep)
  if sep == nil then
    sep = '%s'
  end 
  local res = {}
  local func = function(w)
    table.insert(res, w)
  end 
  string.gsub(str, '[^'..sep..']+', func)
  return res 
end

function FileExists(filename)
  local file = io.open(filename)
  if (file) then
    io.close(file)
    return true
  else
    return false
  end
end

function FileSize(filename)
  file = io.open(filename)
  if not file then
    return -1
  end
  local current = file:seek()      -- get current position
  local size = file:seek("end")    -- get file size
  file:seek("set", current)        -- restore position
  file:close()
  return size
end

function RoundNumber(Number, DecimalPoint)
  return tonumber(string.format("%."..(DecimalPoint or 0).."f", Number))
end
function newStack()
  return {""}
end
function addString (stack, s)
  table.insert(stack, s)
  for i=table.getn(stack)-1, 1, -1 do
    if string.len(stack[i]) > string.len(stack[i+1]) then
      break
    end
    stack[i] = stack[i] .. table.remove(stack)
  end
end
