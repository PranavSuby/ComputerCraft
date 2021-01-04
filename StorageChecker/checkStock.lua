require "lib"
require "storageLib"

local modem = peripheral.wrap(left)

while true do

  for i=1, #drawerTable do
  if drawerTable[i].getItemMeta(2).count < 5 then
    modem.transmit(3,3,drawerTable[i].getItemMeta(2).name .."-Red")
  elseif drawerTable[i].getItemMeta(2).count < 32 then
    modem.transmit(3,3,drawerTable[i].getItemMeta(2).name .."-Yellow")
  else
    modem.transmit(3,3,drawerTable[i].getItemMeta(2).name.."-Green")
  end
end
end
