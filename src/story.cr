module Ton
  player = Entity.new
  player.player = Components::Player.new(true)
  player.character = Components::Character.new(true)
  player.tile = Components::Tile.new("@")
  player.position = Components::Position.new(9, 8)

  camera = Entity.new
  camera.camera = Components::Camera.new(true)
  camera.position = Components::Position.new(5, 7)

  menu = Entity.new
  menu.character_selection_menu = Components::CharacterSelectionMenu.new(true)
  menu.menu = Components::Menu.new([
    Components::MenuItem.new("Move", true, [
      -> (e : Entity) { e.cancel_menu = Components::CancelMenu.new(true); e },
      -> (e : Entity) { e.move_action = Components::MoveAction.new(true); e },
    ]),
    Components::MenuItem.new("Act", false, nil),
    Components::MenuItem.new("Defend", false, nil),
    Components::MenuItem.new("Wait", false, nil),
    Components::MenuItem.new("Cancel", false, [
      -> (e : Entity) { e.cancel_menu = Components::CancelMenu.new(true); e },
      -> (e : Entity) { e.unselect_character = Components::UnselectCharacter.new(true); e },
    ]),
  ])
end
