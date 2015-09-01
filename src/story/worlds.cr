module Ton
  MAIN_MENU_WORLD = World.new("main menu", WorldTypes::MenuWorld)
  PAUSE_WORLD = World.new("pause", WorldTypes::MenuWorld)

  # test stuff
  TEST_BATTLE_WORLD = World.new("test battle", WorldTypes::BattleWorld)
end
