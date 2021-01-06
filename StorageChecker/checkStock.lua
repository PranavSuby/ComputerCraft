require "lib"
require "storageLib"

local modem = peripheral.wrap(left)

local messageSentTable = {}

local yieldTime

local function yield()
  if yieldTime then -- check if it already yielded
    if os.clock() - yieldTime > 2 then -- if it were more than 2 seconds since the last yield
      os.queueEvent("someFakeEvent") -- queue the event
      os.pullEvent("someFakeEvent") -- pull it
      yieldTime = nil -- reset the counter
    end
  else
    yieldTime = os.clock() -- store the time
  end
end

function setItemFalse(itemName) --This function will make the two values False in the messageSentTable corresponding to the same item
  messageSentTable[itemName.."-Red"] = False
  messageSentTable[itemName.."-Yellow"] = False
  messageSentTable[itemName.."-Green"] = False
end

for i=1, #drawerTable do
  messageSentTable[drawerTable[i].getItemMeta(2).name.."-Red"] = false
  messageSentTable[drawerTable[i].getItemMeta(2).name.."-Yellow"] = false
  messageSentTable[drawerTable[i].getItemMeta(2).name.."-Green"] = true
end


message = ""
while true do
  for i=1, #drawerTable do
    if drawerTable[i].getItemMeta(2).count < 5 then
      message = drawerTable[i].getItemMeta(2).name .."-Red"
      local storageName = drawerTable[i].getItemMeta(2).name
      if not messageSentTable[message] then
        modem.transmit(2,2,"Storage-".. storageName .."-Red")
        print(message)
        setItemFalse(storageName)
        messageSentTable[message] = true
      end

    elseif drawerTable[i].getItemMeta(2).count < 32 then
      message = drawerTable[i].getItemMeta(2).name .."-Yellow"
      local storageName = drawerTable[i].getItemMeta(2).name

      if not messageSentTable[message] then
        modem.transmit(2,2,"Storage-".. storageName .."-Yellow")
        print(message)
        setItemFalse(storageName)
        messageSentTable[message] = true
      end

    else
      message = drawerTable[i].getItemMeta(2).name .."-Green"
      local storageName = drawerTable[i].getItemMeta(2).name
      if not messageSentTable[message] then
        modem.transmit(2,2,"Storage-".. storageName .."-Green")
        print(message)
        setItemFalse(storageName)
        messageSentTable[message] = true
      end

    end
  end
  yield()
end
