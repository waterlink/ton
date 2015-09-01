module Ton
  Universe.create(TEST_BATTLE_WORLD) do

    Entity.new.pausable = Components::Pausable.new(PAUSE_WORLD)
    Entity.new.lose_world = Components::LoseWorld.new(LOSE_WORLD)
    Entity.new.win_world = Components::WinWorld.new(WIN_WORLD)

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
    Entity.new.color = Components::Color.new(MAGENTA, BLACK, 5, false)

    status_bar = Entity.new
    status_bar.status_bar = Components::StatusBar.new(true)
    status_bar.status_bar_text = Components::StatusBarText.new("Welcome to Tactics of Nine!")

    status_bar = Entity.new
    status_bar.messages_bar = Components::MessagesBar.new(10)

    character_status = Entity.new
    character_status.character_status = Components::CharacterStatus.new(true)
    character_status.name = Components::Name.new("")
    character_status.health_status = Components::HealthStatus.new("")
    character_status.energy_status = Components::EnergyStatus.new("")
    character_status.action_cost_status = Components::ActionCostStatus.new("")

    target_status = Entity.new
    target_status.target_status = Components::TargetStatus.new(true)
    target_status.name = Components::Name.new("")
    target_status.health_status = Components::HealthStatus.new("")
    target_status.energy_status = Components::EnergyStatus.new("")

    Entity.new.movement_cost_estimate = Components::MovementCostEstimate.new(true)
    Entity.new.attack_cost_estimate = Components::AttackCostEstimate.new(true)

    player = Entity.new
    player.name = Components::Name.new("Rex")
    player.character = Components::Character.new(true)
    player.tile = Components::Tile.new("@")
    player.position = Components::Position.new(9, 8)
    player.blocks_movement = Components::BlocksMovement.new(true)
    player.energy = Components::Energy.new(0, 100)
    player.energy_restoration = Components::EnergyRestoration.new(0.4)
    player.movement_energy_cost = Components::MovementEnergyCost.new(20)
    player.health = Components::Health.new(10, 100)
    player.attack_energy_cost = Components::AttackEnergyCost.new(60)
    player.attack_range = Components::AttackRange.new(1)
    player.damage = Components::Damage.new(20)
    player.targettable = Components::Targettable.new(true)

    player2 = Entity.new
    player2.name = Components::Name.new("John")
    player2.character = Components::Character.new(true)
    player2.tile = Components::Tile.new("@")
    player2.tile_color = Components::TileColor.new(2)
    player2.position = Components::Position.new(10, 8)
    player2.blocks_movement = Components::BlocksMovement.new(true)
    player2.energy = Components::Energy.new(0, 100)
    player2.energy_restoration = Components::EnergyRestoration.new(0.4)
    player2.movement_energy_cost = Components::MovementEnergyCost.new(20)
    player2.health = Components::Health.new(10, 100)
    player2.attack_energy_cost = Components::AttackEnergyCost.new(60)
    player2.attack_range = Components::AttackRange.new(1)
    player2.damage = Components::Damage.new(20)
    player2.targettable = Components::Targettable.new(true)

    player3 = Entity.new
    player3.name = Components::Name.new("Sarah")
    player3.character = Components::Character.new(true)
    player3.tile = Components::Tile.new("@")
    player3.tile_color = Components::TileColor.new(3)
    player3.position = Components::Position.new(8, 8)
    player3.blocks_movement = Components::BlocksMovement.new(true)
    player3.energy = Components::Energy.new(0, 100)
    player3.energy_restoration = Components::EnergyRestoration.new(0.4)
    player3.movement_energy_cost = Components::MovementEnergyCost.new(20)
    player3.health = Components::Health.new(10, 100)
    player3.attack_energy_cost = Components::AttackEnergyCost.new(60)
    player3.attack_range = Components::AttackRange.new(3)
    player3.damage = Components::Damage.new(15)
    player3.targettable = Components::Targettable.new(true)

    player4 = Entity.new
    player4.name = Components::Name.new("Justin")
    player4.character = Components::Character.new(true)
    player4.tile = Components::Tile.new("@")
    player4.tile_color = Components::TileColor.new(4)
    player4.position = Components::Position.new(9, 9)
    player4.blocks_movement = Components::BlocksMovement.new(true)
    player4.energy = Components::Energy.new(0, 100)
    player4.energy_restoration = Components::EnergyRestoration.new(0.4)
    player4.movement_energy_cost = Components::MovementEnergyCost.new(20)
    player4.health = Components::Health.new(10, 100)
    player4.attack_energy_cost = Components::AttackEnergyCost.new(60)
    player4.attack_range = Components::AttackRange.new(1)
    player4.damage = Components::Damage.new(20)
    player4.targettable = Components::Targettable.new(true)

    goblin = Entity.new
    goblin.name = Components::Name.new("Tekka")
    goblin.enemy = Components::Enemy.new(true)
    goblin.tile = Components::Tile.new("g")
    goblin.tile_color = Components::TileColor.new(5)
    goblin.position = Components::Position.new(-5, 2)
    goblin.blocks_movement = Components::BlocksMovement.new(true)
    goblin.energy = Components::Energy.new(0, 100)
    goblin.energy_restoration = Components::EnergyRestoration.new(0.25)
    goblin.movement_energy_cost = Components::MovementEnergyCost.new(20)
    goblin.health = Components::Health.new(50, 50)
    goblin.attack_energy_cost = Components::AttackEnergyCost.new(70)
    goblin.attack_range = Components::AttackRange.new(2)
    goblin.damage = Components::Damage.new(15)
    goblin.targettable = Components::Targettable.new(true)
    goblin.melee_ai = Components::MeleeAi.new(true)

    goblin2 = Entity.new
    goblin2.name = Components::Name.new("Alistair")
    goblin2.enemy = Components::Enemy.new(true)
    goblin2.tile = Components::Tile.new("g")
    goblin2.tile_color = Components::TileColor.new(5)
    goblin2.position = Components::Position.new(-5, 3)
    goblin2.blocks_movement = Components::BlocksMovement.new(true)
    goblin2.energy = Components::Energy.new(0, 100)
    goblin2.energy_restoration = Components::EnergyRestoration.new(0.25)
    goblin2.movement_energy_cost = Components::MovementEnergyCost.new(20)
    goblin2.health = Components::Health.new(50, 50)
    goblin2.attack_energy_cost = Components::AttackEnergyCost.new(70)
    goblin2.attack_range = Components::AttackRange.new(2)
    goblin2.damage = Components::Damage.new(15)
    goblin2.targettable = Components::Targettable.new(true)
    goblin2.melee_ai = Components::MeleeAi.new(true)

    goblin3 = Entity.new
    goblin3.name = Components::Name.new("Guffi")
    goblin3.enemy = Components::Enemy.new(true)
    goblin3.tile = Components::Tile.new("g")
    goblin3.tile_color = Components::TileColor.new(5)
    goblin3.position = Components::Position.new(-7, 3)
    goblin3.blocks_movement = Components::BlocksMovement.new(true)
    goblin3.energy = Components::Energy.new(0, 100)
    goblin3.energy_restoration = Components::EnergyRestoration.new(0.25)
    goblin3.movement_energy_cost = Components::MovementEnergyCost.new(20)
    goblin3.health = Components::Health.new(50, 50)
    goblin3.attack_energy_cost = Components::AttackEnergyCost.new(70)
    goblin3.attack_range = Components::AttackRange.new(2)
    goblin3.damage = Components::Damage.new(15)
    goblin3.targettable = Components::Targettable.new(true)
    goblin3.melee_ai = Components::MeleeAi.new(true)

    camera = Entity.new
    camera.camera = Components::Camera.new(true)
    camera.position = Components::Position.new(5, 7)

    character_selection_menu = Entity.new
    character_selection_menu.character_selection_menu = Components::CharacterSelectionMenu.new(true)
    character_selection_menu.menu = Components::Menu.new("Actions", [
      Components::MenuItem.new("Move", true, [
        -> (e : Entity) { e.cancel_menu = Components::CancelMenu.new(true); e },
        -> (e : Entity) { e.move_action = Components::MoveAction.new(true); e },
      ]),
      Components::MenuItem.new("Act", false, [
        -> (e : Entity) { e.activate_act_submenu = Components::ActivateActSubmenu.new(true); e },
      ]),
      Components::MenuItem.new("Defend", false, nil),
      Components::MenuItem.new("Wait", false, nil),
      Components::MenuItem.new("Cancel", false, [
        -> (e : Entity) { e.cancel_menu = Components::CancelMenu.new(true); e },
        -> (e : Entity) { e.unselect_character = Components::UnselectCharacter.new(true); e },
      ]),
    ])

    act_submenu = Entity.new
    act_submenu.act_submenu = Components::ActSubmenu.new(true)
    act_submenu.menu = Components::Menu.new("Actions>Act", [
      Components::MenuItem.new("Attack", true, [
        -> (e : Entity) { e.cancel_menu = Components::CancelMenu.new(true); e },
        -> (e : Entity) { e.attack_action = Components::AttackAction.new(true); e },
      ]),
      Components::MenuItem.new("Skill", false, nil),
      Components::MenuItem.new("Item", false, nil),
      Components::MenuItem.new("Cancel", false, [
        -> (e : Entity) { e.cancel_menu = Components::CancelMenu.new(true); e },
      ]),
    ])

  end
end
