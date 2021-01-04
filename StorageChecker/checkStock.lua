require "lib"

oakLeaves = "storagedrawers:basicdrawers_1_0"

local modem = peripheral.wrap(left)

openModem(2, modem)

oakLeavesDrawer = peripheral.wrap(oakLeaves)

while true do
  if oakLeavesDrawer.getItemMeta(2).count < 5 then
    modem.transmit(2,2,"Storage:OakLeaves:Red")
  elseif oakLeavesDrawer.getItemMeta(2).count < 32 then
    modem.transmit(2,2,"Storage:OakLeaves:Yellow")
  end
end
