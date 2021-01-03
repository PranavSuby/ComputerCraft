require "lib"

local modules = peripheral.wrap(back)
local canvas = modules.canvas()
local modem =  peripheral.wrap(left)

local healthString = ""
local healthTextBox = canvas.addGroup({165, 260})
healthTextBox.addRectangle(0,0,20,10, 0x00000000)


while true do
  local info = modules.getMetaOwner()
  local health = info.health
  local maxHealth = info.maxHealth

  if math.floor(health) < health then
    health = math.floor(health) + 1
  else
    health = math.floor(health)
  end

  if math.floor(maxHealth) < maxHealth then
    maxHealth = math.floor(maxHealth) + 1
  else
    maxHealth = math.floor(maxHealth)
  end

  healthTextBox.clear()
  healthString = tostring(health) .. "/" .. tostring(maxHealth)
  local healthText = healthTextBox.addText({0,3.59}, healthString, 0xD44646FF)
  healthText.setScale(0.57)
end
