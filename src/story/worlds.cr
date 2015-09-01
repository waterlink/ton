module Ton
  # menus
  MAIN_MENU_WORLD = World.new("main menu", WorldTypes::MenuWorld)
  PAUSE_WORLD = World.new("pause", WorldTypes::MenuWorld)

  # win & lose
  LOSE_WORLD = World.new("lose", WorldTypes::MenuWorld)
  WIN_WORLD = World.new("win", WorldTypes::MenuWorld)

  # map overview
  MAP_OVERVIEW_WORLD = World.new("map overview", WorldTypes::MapOverview)

  # test stuff
  TEST_BATTLE_WORLD = World.new("test battle", WorldTypes::BattleWorld)
end
