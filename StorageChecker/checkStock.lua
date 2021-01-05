require "lib"

local modem = peripheral.wrap(left)

local oakLeaves = "storagedrawers:basicdrawers_1_0"

drawerTable = {
  peripheral.wrap(oakLeaves)
}

drawerTableReverse = reverseIndex(drawerTable)

while true do

  for i=1, #drawerTable do
  if drawerTable[i].getItemMeta(2).count < 5 then
    modem.transmit(3,3,drawerTable[i].getItemMeta(2).name .."-Red")
    print("red"..drawerTable[i].getItemMeta(2).name)
  elseif drawerTable[i].getItemMeta(2).count < 32 then
    modem.transmit(3,3,drawerTable[i].getItemMeta(2).name .."-Yellow")
    print("yellow"..drawerTable[i].getItemMeta(2).name)
  else
    modem.transmit(3,3,drawerTable[i].getItemMeta(2).name.."-Green")
    print("green"..drawerTable[i].getItemMeta(2).name)
  end
end
end
