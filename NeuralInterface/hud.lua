require "lib"

local modules = peripheral.wrap(back)
local canvas = modules.canvas()
local modem =  peripheral.wrap(left)

local reactorTextBox = canvas.addGroup({ 0, 0 })
local armorTextBox = canvas.addGroup({0, 30})
local storageGroup = canvas.addGroup({490,120})
local storageTable = {}

local itemBaseWidth = 16
local itemBaseHeight = 16


function size(obj)
  local scale = obj.getScale()
  return itemBaseWidth*scale, itemBaseHeight*scale
end

function drawCircle(r, x, y, c, g1)
  for j=0, r do
    for i = 1, 360 do
      local angle = i * math.pi / 180
      local ptx, pty = x + j * math.cos( angle ), y + j * math.sin( angle )
      g1.addDot({ptx, pty}, c)
    end
  end
end


openModem(2, modem)

while true do
  local event, p1, p2, p3, p4, p5, p6 = os.pullEvent()

  if event == "modem_message" then
    local message = p4
    if message == "Reactor Warning!!!" then
      local text = reactorTextBox.addText({ 5, 5 }, message)
      text.setScale(3)
      text.setColor(255, 0, 0, 255)

    elseif message == "Reactor Good" then
      reactorTextBox.clear()

    elseif message == "Repair Living Armor Now" then
      local text = armorTextBox.addText({5, 5}, message)
      text.setScale(1.75)
      text.setColor(255, 0, 0, 255)

    elseif message == "Armor Good"  then
      armorTextBox.clear()

    elseif string.find(message, "Storage") then
      local reverseStorage = reverseIndex(storageTable)
      local storageMessage = split(p4, "-") --Message in the form of "Storage-<itemId>-<color>" Example "Storage-minecraft:leaves-Yellow"
      local storageItemName = storageMessage[2]
      local storageColor = storageMessage[3]
      local colorTable = {
        ["Yellow"] = 0xFFCC0080,
        ["Red"] = 0xD4464680
      }


      if storageColor ~= "Green" then

        if storageColor == "Yellow" and reverseStorage[{storageItemName, colorTable["Red"]}] ~= nil then table.remove(storageTable, reverseStorage[{storageItemName, colorTable["Red"]}])
        elseif storageColor == "Red" and reverseStorage[{storageItemName, colorTable["Yellow"]}] ~= nil then table.remove(storageTable, reverseStorage[{storageItemName, colorTable["Yellow"]}]) end

        storageTable[#storageTable+1] = {storageItemName, colorTable[storageColor]}
      else
        if reverseStorage[{storageItemName, colorTable["Yellow"]}] ~= nil then table.remove(storageTable, reverseStorage[{storageItemName, colorTable["Yellow"]}])
        elseif reverseStorage[{storageItemName, colorTable["Red"]}] ~= nil then table.remove(storageTable, reverseStorage[{storageItemName, colorTable["Red"]}]) end


      end

      for k,v in pairs(reverseStorage) do
        print(v)
        for j,w in pairs(k) do
          print(j)
          print(w)
        end
        print(reverseStorage[v])
        print(reverseStorage[k])
      end

      local sideNum = 3 --How many storage alerts per row/column

      storageGroup.clear()

      for i=1, #storageTable do
        local tempGroup = storageGroup.addGroup({(-16 * math.floor((i-1)/sideNum))-8,(16*((i-1)%sideNum))-8})
        drawCircle(8, 8, 8, storageTable[i][2], tempGroup)
        tempGroup.addItem({0,0}, storageTable[i][1])
      end

    end


  elseif event=="key" then
    local key = p1

    if key == keys.q then
      reactorTextBox.clear()
      armorTextBox.clear()
      break
    end

  end

end
