front = "front"
back = "back"
right = "right"
left = "left"
top = "top"
bottom = "bottom"

function openModem(channel, modem)
  if modem.isOpen(channel) ~= true then
    modem.open(channel)
  end
end

function split (inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

function reverseIndex(t)
  local tReversed = {}
  for k, v in pairs(t) do
    tReversed[v] = k
  end
  return tReversed
end


--EVERYTHING BELOW IS FOR THE UPDATE FILES
files = {
  ["AllComputers"] = {"update.lua", "lib.lua", "updateBaseFiles.lua", "updateComputerFiles.lua"},
  ["ArmorChecker"] = {"armorAlert.lua", "startup.lua"},
  ["BaseScreen"] = {"modularMachineryPartsList.lua", "startup.lua"},
  ["NeuralInterface"] = {"debugHud.lua", "healthHud.lua", "hud.lua", "clearHud.lua", "startup.lua"},
  ["StorageChecker"] = {"checkStock.lua", "storageLib.lua", "startup.lua"}
}

keyset = {}

for k,v in pairs(files) do
  keyset[#keyset+1] = k
end
