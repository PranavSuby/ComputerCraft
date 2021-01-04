require "lib"
require "storageLib"

local modem = peripheral.wrap(left)

openModem(1, modem)
openModem(3, modem)

message = ""

local messageSentTable = {}

function setItemFalse(itemName) --This function will make the two values False in the messageSentTable corresponding to the same item
  messageSentTable[itemName.."-Red"] = False
  messageSentTable[itemName.."-Yellow"] = False
  messageSentTable[itemName.."-Green"] = True
end

--TODO When checkStock.lua sends a message changing the color, I have to send a message erasing the color from the hud and remaking it, maybe put that in setItemFalse(). I also need to send a message when everythign is good

for i=1, #drawerTable do
  messageSentTable[drawerTable[i].getItemMeta(2).name.."-Red"] = False
  messageSentTable[drawerTable[i].getItemMeta(2).name.."-Yellow"] = False
  messageSentTable[drawerTable[i].getItemMeta(2).name.."-Green"] = False
end

while true do
  local event, peripheral_name, channel, replyChannel, message, distance = os.pullEvent("modem_message")
  local storageMessage = split(message, "-")

  local storageItemName = storageMessage[1]
  local storageColor = storageMessage[2]

  if channel == 3 then --Receiving Message from checkStock.lua
    if not messageSentTable[message] then
      if storageColor ~= "Green"
      modem.transmit(2,2,"Storage-".. drawerTable[drawerTableReverse[storageItemName]].getItemMeta(2).name ..storageColor)
      setItemFalse(storageName)
      messageSentTable[message] = True
    else
      setItemFalse(storageName)
      messageSentTable[message] = True
    end
    end

  else if channel == 1 then --Receiving Message from NeuralInterface/hud.lua
    messageSentTable[message] = True
  end
end
