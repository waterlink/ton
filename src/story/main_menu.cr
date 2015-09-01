module Ton
  Universe.create(MAIN_MENU_WORLD) do
    menu = Entity.new
    menu.active_menu = Components::ActiveMenu.new(true)
    menu.menu = Components::Menu.new("Main Menu", [
      Components::MenuItem.new("New Game", true, nil),
      Components::MenuItem.new("Continue", false, nil),
      Components::MenuItem.new("Options", false, nil),
      Components::MenuItem.new("Credits", false, nil),
      Components::MenuItem.new("TEST battle", false, [
        -> (e : Entity) { e.switch_to_world = Components::SwitchToWorld.new(TEST_BATTLE_WORLD); e },
      ]),
      Components::MenuItem.new("Quit", false, [
        -> (e : Entity) { e.quit = Components::Quit.new(true); e },
      ]),
    ])
  end
end
