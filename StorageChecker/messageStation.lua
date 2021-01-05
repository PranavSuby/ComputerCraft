require "lib"
require "storageLib"
require "checkStock"

local modem = peripheral.wrap(left)

local messageSentTable = {}

function setItemFalse(itemName) --This function will make the two values False in the messageSentTable corresponding to the same item
  messageSentTable[itemName.."-Red"] = False
  messageSentTable[itemName.."-Yellow"] = False
  messageSentTable[itemName.."-Green"] = False
end

--TODO When checkStock.lua sends a message changing the color, I have to send a message erasing the color from the hud and remaking it, maybe put that in setItemFalse(). I also need to send a message when everythign is good

for i=1, #drawerTable do
  messageSentTable[drawerTable[i].getItemMeta(2).name.."-Red"] = False
  messageSentTable[drawerTable[i].getItemMeta(2).name.."-Yellow"] = False
  messageSentTable[drawerTable[i].getItemMeta(2).name.."-Green"] = True
end

while true do
  local storageMessage = split(message, "-")

  local storageItemName = storageMessage[1]
  local storageColor = storageMessage[2]

  if channel == 3 then --Receiving Message from checkStock.lua
    if not messageSentTable[message] then
        modem.transmit(2,2,"Storage-".. drawerTable[drawerTableReverse[storageItemName]].getItemMeta(2).name ..storageColor)
        setItemFalse(storageName)
        print("Channel 3")
        messageSentTable[message] = True
    end

  elseif channel == 1 then --Receiving Message from NeuralInterface/hud.lua
    print("Channel 1")
    messageSentTable[message] = True
  end
end
