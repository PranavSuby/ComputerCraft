require "lib"

local modules = peripheral.wrap(back)
local canvas = modules.canvas()
local modem =  peripheral.wrap(left)
local reactorTextBox = canvas.addGroup({ 0, 0 })
local armorTextBox = canvas.addGroup({0, 30})

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
