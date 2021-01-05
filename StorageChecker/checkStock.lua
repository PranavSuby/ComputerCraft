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
      if not messageSentTable[message] then
        modem.transmit(2,2,"Storage-".. drawerTable[drawerTableReverse[storageItemName]].getItemMeta(2).name .."Red")
        print("red"..drawerTable[i].getItemMeta(2).name)
      end
    elseif drawerTable[i].getItemMeta(2).count < 32 then
      message = drawerTable[i].getItemMeta(2).name .."-Red"
      if not messageSentTable[message] then

        modem.transmit(2,2,"Storage-".. drawerTable[drawerTableReverse[storageItemName]].getItemMeta(2).name .."Yellow")
        print("yellow"..drawerTable[i].getItemMeta(2).name)
      end
    else
      if not messageSentTable[message] then

        message = drawerTable[i].getItemMeta(2).name .."-Red"
        modem.transmit(2,2,"Storage-".. drawerTable[drawerTableReverse[storageItemName]].getItemMeta(2).name .."Green")

        print("green"..drawerTable[i].getItemMeta(2).name)
      end
    end
  end
end
