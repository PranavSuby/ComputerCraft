require "lib"

for k,v in pairs(files[os.getComputerLabel()]) do
  shell.run("update "..v)
end
