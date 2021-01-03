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
