module Ton
  Universe.create(LOSE_WORLD) do
    menu = Entity.new
    menu.active_menu = Components::ActiveMenu.new(true)
    menu.menu = Components::Menu.new("GAME OVER", [
      Components::MenuItem.new("Main Menu", true, [
        -> (e : Entity) { e.switch_to_world = Components::SwitchToWorld.new(MAIN_MENU_WORLD); e },
        -> (e : Entity) { e.reset_universe = Components::ResetUniverse.new(true); e },
      ]),
    ])
  end
end
