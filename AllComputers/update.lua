require "lib"

tArgs = {...}

fileName = tArgs[1]

function get(repoFile, repoFolder, saveTo)
  local download = http.get("https://raw.githubusercontent.com/PranavSuby/ComputerCraft/master/"..repoFolder.."/"..repoFile) --This will make 'download' hold the contents of the file.
  if download then --checks if download returned true or false
    local handle = download.readAll() --Reads everything in download
    download.close() --remember to close the download!
    local file = fs.open(saveTo,"w") --opens the file defined in 'saveTo' with the permissions to write.
    file.write(handle) --writes all the stuff in handle to the file defined in 'saveTo'
    file.close() --remember to close the file!
  else --if returned false
    print("Unable to download the file "..repoFolder.."/"..repoFile)
    print("Make sure you have the HTTP API enabled or")
    print("an internet connection!")
  end --end the
end --close the function

function doesItExist(list, value)
  local exists = false
  for k, v in pairs(list) do
    if list[k] == value then
      exists = true
      break
    end
  end
  return exists
end

  filePath = ""

  if string.sub(fileName, -4) == ".lua" then
    filePath = fileName
  else
    filePath = fileName .. ".lua"
  end

  local fileFolder = ""

  if doesItExist(files[os.getComputerLabel()], filePath) then
    fileFolder =  os.getComputerLabel()
    print("Found in Same Folder: "..fileFolder)
  else

    for k,v in pairs(keyset) do
      if doesItExist(files[v], filePath) then
        fileFolder = v
        print("found in different folder "..tostring(v))
        break
      end
    end

  end

  if fileFolder ~= "" then
    get(filePath, fileFolder, filePath)
  else
    print("File Folder Does Not Exist")
  end
