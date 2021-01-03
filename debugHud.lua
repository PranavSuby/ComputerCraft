require "lib"

local modules = peripheral.wrap(back)
local canvas = modules.canvas()
local modem =  peripheral.wrap(left)

canvas.clear()

debug = canvas.addGroup({0,0})
local width, height = canvas.getSize()

for i=0, width, 10 do
  debug.addLine({i,0},{i,height})
end

for i=0, height, 10 do
  debug.addLine({0,i},{width,i})
end
