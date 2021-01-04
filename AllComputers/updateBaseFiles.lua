require "lib"

for k,v in pairs(files.AllComputers) do
  shell.run("update "..v)
end
