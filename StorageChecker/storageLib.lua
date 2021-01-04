require "lib"

local oakLeaves = "storagedrawers:basicdrawers_1_0"

drawerTable = {
  peripheral.wrap(oakLeaves)
}

drawerTableReverse = reverseIndex(drawerTable)
