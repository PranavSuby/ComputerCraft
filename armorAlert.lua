require "lib"

local modem = peripheral.wrap(top)

if modem.isOpen(2) ~= true then
  modem.open(2)
end

while true do
  os.pullEvent("redstone")

  if redstone.getInput("left") then
    modem.transmit(2, 2, "Repair Living Armor Now")
  else
    modem.transmit(2,2, "Armor Good")
  end

end
