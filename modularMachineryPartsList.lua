--[[ Declare a table with the buttons that will be printed,
with it's own Text Colour and Background Colour and
unique x and y values.
--]]
require "lib"

t = {
  {text = "Starlight Crafting Engine", x = 1, y = 3, txtCol = colours.blue, bgCol = colours.white},
  {text = "Arcane Crafting Engine", x = 1, y = 5, txtCol = colours.blue, bgCol = colours.white},
  {text = "Advanced Metallurgic Fabricator", x = 1, y = 7, txtCol = colours.blue, bgCol = colours.white},
  {text = "Advanced Thermionic Fabricator", x = 1, y = 9, txtCol = colours.blue, bgCol = colours.white},
  {text = "Advanced Carpenter", x = 1, y = 11, txtCol = colours.blue, bgCol = colours.white},
  {text = "Back", x = 1, y = 1}
}

starlightCraftingEngine = {
  {text = "Back"},
  {text = "Machine Controller", amount = 1},
  {text = "Fluid Input Hatch", amount = 1},
  {text = "Item Input", amount = 1},
  {text = "Item Output", amount = 1},
  {text = "Marble Bricks", amount = 79},
  {text = "Marble Stairs", amount = 16},
  {text = "Marble Pillar", amount = 8},
  {text = "Runed Marble", amount = 12},
  {text = "Chiseled Marble", amount = 4},
  {text = "Marble", amount = 17},
  {text = "Sooty Marble", amount = 49},
  {text = "Engraved Marble", amount = 4},
  {text = "Iridescent Altar", amount = 1}
}

arcaneCraftingEngine = {
  {text = "Back"},
  {text = "Machine Controller", amount = 1},
  {text = "Item Input", amount = 1},
  {text = "Item Output", amount = 1},
  {text = "Arcane Pattern Crafter", amount = 4},
  {text = "Arcane Workbench", amount = 1},
  {text = "Order Crystal", amount = 3},
  {text = "Arcane Stone Brick", amount = 8},
  {text = "Stabilizer", amount = 4},
  {text = "Arcane Stone", amount = 4},
  {text = "Redstone Inlay", amount = 2},
  {text = "Workbench Charger", amount = 1},
  {text = "Vis Battery", amount = 9}
}

advancedMetallurgicFabricator = {
  {text = "Back"},
  {text = "Machine Controller", amount = 1},
  {text = "Item Input", amount = 1},
  {text = "Item Output", amount = 1},
  {text = "Energy Input Hatch", amount = 1},
  {text = "Fluid Input Hatch", amount = 1},
  {text = "Machine Vent", amount = 4},
  {text = "Machine Circuitry", amount = 2},
  {text = "Mutagen", amount = 6},
  {text = "Machine Casing", amount = 31}
}

advancedThermionicFabricator = {
  {text = "Back"},
  {text = "Machine Controller", amount = 1},
  {text = "Item Input", amount = 1},
  {text = "Item Output", amount = 1},
  {text = "Energy Input Hatch", amount = 1},
  {text = "Fluid Input Hatch", amount = 1},
  {text = "Machine Vent", amount = 4},
  {text = "Block of Steel (Immersive Engineering)", amount = 8},
  {text = "64k Crafting Storage", amount = 4},
  {text = "Crafting Co-Processing Unit", amount = 4},
  {text = "Blazing Pyrotheum", amount = 9},
  {text = "Machine Casing", amount = 49}
}

advancedCarpenter = {
  {text = "Back"},
  {text = "Machine Controller", amount = 1},
  {text = "Item Input", amount = 1},
  {text = "Item Output", amount = 1},
  {text = "Energy Input Hatch", amount = 1},
  {text = "Fluid Input Hatch", amount = 1},
  {text = "Machine Vent", amount = 3},
  {text = "Machine Gearbox", amount = 1},
  {text = "Crafting Co-Processing Unit", amount = 8},
  {text = "Processor (RF Tools)", amount = 1},
  {text = "Multi Tank", amount = 1},
  {text = "Gelid Cryotheum", amount = 7},
  {text = "Machine Casing", amount = 45}
}


mon = peripheral.wrap(left)

function writeButtons(_table)
  for i, v in pairs(_table) do
    if v.text ~= "Back" then
      mon.setCursorPos(v.x, v.y)
      mon.setTextColour(v.txtCol)
      mon.setBackgroundColour(v.bgCol)
      mon.write(v.text)
    end

  end
end

function writeIngredients(_table)
  for i, v in pairs(_table) do
    if v.text == "Back" then
      backButton()
    else
      mon.setCursorPos(1, 2*i + 1)
      mon.setTextColor(colors.white)
      mon.setBackgroundColour(colors.black)
      ingredient = tostring(v.amount) .. "x " .. v.text
      mon.write(ingredient)
    end
  end
end

function isValidClick(_table, mx, my)
  for i, v in pairs(_table) do
    if mx >= v.x and mx <= (v.x + #v.text) and my == v.y then
      return true, v.text
    end
  end
  return false, nil
end

function backButton()
  mon.setCursorPos(1,1)
  mon.setTextColor(colors.blue)
  mon.setBackgroundColour(colors.white)
  mon.write("Back")
end

function clearScreen()
  mon.setBackgroundColour(colors.black)
  mon.clear()
end

clearScreen()

writeButtons(t)

while true do
  _, but, x, y = os.pullEvent("monitor_touch")
  bClick, option = isValidClick(t, x, y)
  if bClick then
    -- Yes, it's a valid click. Now let's do something with the returned text 'option'
    clearScreen()
    if option == "Starlight Crafting Engine" then -- button 1...
      writeIngredients(starlightCraftingEngine)

    elseif option == "Arcane Crafting Engine" then
      writeIngredients(arcaneCraftingEngine)

    elseif option == "Advanced Metallurgic Fabricator" then
      writeIngredients(advancedMetallurgicFabricator)

    elseif option == "Advanced Thermionic Fabricator" then
      writeIngredients(advancedThermionicFabricator)

    elseif option == "Advanced Carpenter" then
      writeIngredients(advancedCarpenter)

    elseif option == "Back" then
      writeButtons(t)
    end

  end
end
