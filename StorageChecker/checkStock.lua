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

function doesExist(iterNum)
  return drawerTable[iterNum].getItemMeta(2).count
end

for i=1, #drawerTable do

  messageSentTable[drawerTableKeys[i].."-Red"] = false
  messageSentTable[drawerTableKeys[i].."-Yellow"] = false
  messageSentTable[drawerTableKeys[i].."-Green"] = true
end

message = ""
while true do
  for i=1, #drawerTable do
    local itemName = drawerTableKeys[i]
    local itemCount = 0

    local status, res = pcall(doesExist,i)

    if status then
      itemCount = res
    end

    if itemCount < 5 then
      message = itemName .."-Red"

      if not messageSentTable[message] then
        print(message)
        modem.transmit(2,2,"Storage-".. itemName .."-Red")
        setItemFalse(itemName)
        messageSentTable[message] = true
      end

    elseif itemCount < 32 then
      message = itemName .."-Yellow"

      if not messageSentTable[message] then
        print(message)
        modem.transmit(2,2,"Storage-".. itemName .."-Yellow")
        setItemFalse(itemName)
        messageSentTable[message] = true
      end

    elseif itemCount >= 32 then
      message = itemName .."-Green"

      if not messageSentTable[message] then
        print(message)
        modem.transmit(2,2,"Storage-".. itemName .."-Green")
        setItemFalse(itemName)
        messageSentTable[message] = true
      end
    end

  end
  yield()
end
