tArgs = {...}

fileName = tArgs[1]

local files = {"update.lua", "replace.lua", "hud.lua", "lib.lua", "debugHud.lua", "healthHud.lua", "armorAlert.lua"}
local pastebinCodes = {"np5fTVg4", "yw0rNgb9", "bsuE6Zwq", "mfECX223", "trEfEny5", "u7EY0a0P", "diQiq3dC"}
local index={}
for k,v in pairs(files) do
   index[v]=k
end
filePath = ""
if string.sub(fileName, -4) == ".lua" then
	filePath = fileName
else
	filePath = fileName .. ".lua"
end

local indexValue = index[filePath]
local code = pastebinCodes[indexValue]
shell.run("delete", filePath)
shell.run("pastebin", "get", code, filePath)
