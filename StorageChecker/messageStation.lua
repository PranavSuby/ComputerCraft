require "lib"
require "storageLib"


local modem = peripheral.wrap(left)

openModem(1, modem)
openModem(3, modem)

message = ""



while true do
  local event, peripheral_name, channel, replyChannel, message, distance = os.pullEvent("modem_message")
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
