module Ton
  Universe.create(WIN_WORLD) do
    menu = Entity.new
    menu.active_menu = Components::ActiveMenu.new(true)
    menu.menu = Components::Menu.new("YOU WON!", [
      Components::MenuItem.new("Continue", true, [
        -> (e : Entity) { e.switch_to_world = Components::SwitchToWorld.new(MAP_OVERVIEW_WORLD); e },
      ]),
    ])
  end
end
