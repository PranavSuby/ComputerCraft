require "lib"

local modules = peripheral.wrap(back)
local canvas = modules.canvas()
local modem =  peripheral.wrap(left)

local reactorTextBox = canvas.addGroup({ 0, 0 })
local armorTextBox = canvas.addGroup({0, 30})
local storageGroup = canvas.addGroup({490,120})

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
      local storageMessage = split(p4, ":")
      if storageMessage[2] == "OakLeaves" then
        print("1")
        --drawCircle(10, 0, 0, 0xD44646FF, storageGroup)
        storageGroup.addItem({8,8}, "minecraft:leaves")
      end
    else
      print(message)
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
