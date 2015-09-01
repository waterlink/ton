require "./main_menu"

module Ton
  Universe.create(PAUSE_WORLD) do
    menu = Entity.new
    menu.active_menu = Components::ActiveMenu.new(true)
    menu.menu = Components::Menu.new("Pause Menu", [
      Components::MenuItem.new("Continue", true, [
        -> (e : Entity) { e.unpause = Components::Unpause.new(true); e },
      ]),
      Components::MenuItem.new("Options", false, nil),
      Components::MenuItem.new("Main Menu", false, [
        -> (e : Entity) { e.switch_to_world = Components::SwitchToWorld.new(MAIN_MENU_WORLD); e },
        -> (e : Entity) { e.reset_universe = Components::ResetUniverse.new(true); e },
      ]),
    ])
  end
end
