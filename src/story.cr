module Ton
  BLACK = 0
  RED = 1
  GREEN = 2
  YELLOW = 3
  BLUE = 4
  MAGENTA = 5
  CYAN = 6
  WHITE = 7

  Entity.new.color = Components::Color.new(GREEN, BLACK, 2, false)
  Entity.new.color = Components::Color.new(YELLOW, BLACK, 3, false)
  Entity.new.color = Components::Color.new(CYAN, BLACK, 4, false)

  status_bar = Entity.new
  status_bar.status_bar = Components::StatusBar.new(true)
  status_bar.status_bar_text = Components::StatusBarText.new("Welcome to Tactics of Nine!")

  player = Entity.new
  player.character = Components::Character.new(true)
  player.tile = Components::Tile.new("@")
  player.position = Components::Position.new(9, 8)
  player.blocks_movement = Components::BlocksMovement.new(true)
  player.energy = Components::Energy.new(0, 100)
  player.energy_restoration = Components::EnergyRestoration.new(0.4)
  player.movement_energy_cost = Components::MovementEnergyCost.new(20)

  player2 = Entity.new
  player2.character = Components::Character.new(true)
  player2.tile = Components::Tile.new("@")
  player2.tile_color = Components::TileColor.new(2)
  player2.position = Components::Position.new(10, 8)
  player2.blocks_movement = Components::BlocksMovement.new(true)
  player2.energy = Components::Energy.new(0, 100)
  player2.energy_restoration = Components::EnergyRestoration.new(0.4)
  player2.movement_energy_cost = Components::MovementEnergyCost.new(20)

  player3 = Entity.new
  player3.character = Components::Character.new(true)
  player3.tile = Components::Tile.new("@")
  player3.tile_color = Components::TileColor.new(3)
  player3.position = Components::Position.new(8, 8)
  player3.blocks_movement = Components::BlocksMovement.new(true)
  player3.energy = Components::Energy.new(0, 100)
  player3.energy_restoration = Components::EnergyRestoration.new(0.4)
  player3.movement_energy_cost = Components::MovementEnergyCost.new(20)

  player4 = Entity.new
  player4.character = Components::Character.new(true)
  player4.tile = Components::Tile.new("@")
  player4.tile_color = Components::TileColor.new(4)
  player4.position = Components::Position.new(9, 9)
  player4.blocks_movement = Components::BlocksMovement.new(true)
  player4.energy = Components::Energy.new(0, 100)
  player4.energy_restoration = Components::EnergyRestoration.new(0.4)
  player4.movement_energy_cost = Components::MovementEnergyCost.new(20)

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
