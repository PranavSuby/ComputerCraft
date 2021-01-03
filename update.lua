tArgs = {...}

fileName = tArgs[1]

function get(repoFile,saveTo)
  local download = http.get("https://raw.github.com/PranavSuby/ComputerCraft".. repoFile) --This will make 'download' hold the contents of the file.
  if download then --checks if download returned true or false
    local handle = download.readAll() --Reads everything in download
    download.close() --remember to close the download!
    local file = fs.open(saveTo,"w") --opens the file defined in 'saveTo' with the permissions to write.
    file.write(handle) --writes all the stuff in handle to the file defined in 'saveTo'
    file.close() --remember to close the file!
  else --if returned false
    print("Unable to download the file "..repoFile)
    print("Make sure you have the HTTP API enabled or")
    print("an internet connection!")
  end --end the
end --close the function


local files = {"update.lua", "replace.lua", "hud.lua", "lib.lua", "debugHud.lua", "healthHud.lua", "armorAlert.lua"}

filePath = ""

if string.sub(fileName, -4) == ".lua" then
	filePath = fileName
else
	filePath = fileName .. ".lua"
end

get(filePath, filePath)
