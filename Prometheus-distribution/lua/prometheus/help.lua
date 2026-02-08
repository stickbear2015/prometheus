-- Main module for documentation, provides main page and the sphelp alias.
putils = require("prometheus.util")
path = require("pl.path")
ImportXML([[<aliases>
  <alias name="sphelpIndex" match="sphelp" group="sphelp" script="sphelpIndex"
enabled="y" send_to="12" ignore_case="y" sequence="100"></alias>
<alias name="sphelpFile" match="sphelp *" group="sphelp" script="sphelp"
enabled="y" send_to="12" ignore_case="y" sequence="100"></alias>
</aliases>]])

local helpFiles = {}

function sphelp(n, l, w)
if w[1] == "list" then
Note(listAllHelp())
else
local result = helpSearch(w[1])
if type(result) == "string" then
Note(showHelp(result))
elseif type(result) == "table" then
ret = utils.choose("pick the desired help file, then press enter.","Soundpack help search results",result)
if ret then
Note(showHelp(result[ret]))
else
utils.msgbox("help file selection canceled.","Information","ok","i")
end
elseif type(result) == "nil" then
utils.msgbox("no results found.","Warning")
end
end
end

function sphelpIndex(n, l, w)
Note(showHelp("introduction"))
Note("On the following pages, you can find information about:")
Note(listAllHelp())
end

function loadHelp()
local files = string.gsub(GetInfo(66), "\\", "/").."/docs"
for file in path.dir(files) do
if file ~= "." and file ~= ".." then
local f = io.open(files.."/"..file,"r")
local first, second, third = f:read("l*","l*","l*")
f:close()
table.insert(helpFiles, {
['name'] = tostring(first):lower():gsub("%s",""),
['path'] = tostring(files.."/"..file),
['description'] = third:sub(14),
['keywords'] = utils.split(second:sub(10):gsub("%s",""),",")})
end
end
end
loadHelp()

function helpSearch(keyword)
local matches = {}
for _, file in ipairs(helpFiles) do
for i, v in ipairs(file.keywords) do
if keyword == v then
if #matches <= 1 then
matches[1] = file.name
else
matches[#matches+1] = file.name
end
end
end
end
if not(#matches) then
return
elseif #matches then
return tostring(matches[1])
else 
return matches
end
matches = nil
end

function showHelp(requested)
for i, entry in ipairs(helpFiles) do
if tostring(entry.name) == requested then 
local data = io.open(entry.path:gsub("/","\\"),"r")
ret = data:read("*a")
data:close()
end
end
return ret
end

function listAllHelp()
local listings = putils.newStack()
for i, file in ipairs(helpFiles) do
putils.addString(listings, "* "..tostring(file.name).." -> "..
tostring(file.description).."\n")
end
local function RemoveLastLine(str)
local pos = 0
while true do
local nl = string.find(str, "\n", pos, true)
if not nl then break end
pos = nl + 1
end
if pos == 0 then return str end
return string.sub(str, 1, pos - 2)
end  
return RemoveLastLine(table.concat(listings))
end
