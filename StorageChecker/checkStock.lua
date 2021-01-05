require "lib"
require "storageLib"

local modem = peripheral.wrap(left)

local messageSentTable = {}

function setItemFalse(itemName) --This function will make the two values False in the messageSentTable corresponding to the same item
  messageSentTable[itemName.."-Red"] = False
  messageSentTable[itemName.."-Yellow"] = False
  messageSentTable[itemName.."-Green"] = False
end

for i=1, #drawerTable do
  messageSentTable[drawerTable[i].getItemMeta(2).name.."-Red"] = False
  messageSentTable[drawerTable[i].getItemMeta(2).name.."-Yellow"] = False
  messageSentTable[drawerTable[i].getItemMeta(2).name.."-Green"] = True
end

message = ""
while true do
  for i=1, #drawerTable do
    if drawerTable[i].getItemMeta(2).count < 5 then
      message = drawerTable[i].getItemMeta(2).name .."-Red"
      local storageName = drawerTable[i].getItemMeta(2).name
      if not messageSentTable[message] then
        modem.transmit(2,2,"Storage-".. storageName .."-Red")
        print("red"..storageName)
        setItemFalse(storageName)
        messageSentTable[message] = True
      end

    elseif drawerTable[i].getItemMeta(2).count < 32 then
      message = drawerTable[i].getItemMeta(2).name .."-Red"
      local storageName = drawerTable[i].getItemMeta(2).name

      if not messageSentTable[message] then
        modem.transmit(2,2,"Storage-".. storageName .."-Yellow")
        print("yellow"..storageName)
        setItemFalse(storageName)
        messageSentTable[message] = True
      end

    else
      message = drawerTable[i].getItemMeta(2).name .."-Red"
      local storageName = drawerTable[i].getItemMeta(2).name
      if not messageSentTable[message] then
        modem.transmit(2,2,"Storage-".. storageName .."-Green")
        print("green"..storageName)
        setItemFalse(storageName)
        messageSentTable[message] = True
      end

    end
  end
end
