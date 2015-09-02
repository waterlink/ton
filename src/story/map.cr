module Ton
  Universe.create(MAP_OVERVIEW_WORLD) do
    Entity.new.pausable = Components::Pausable.new(PAUSE_WORLD)

    Entity.new.color = Components::Color.new(GREEN, BLACK, 2, false)
    Entity.new.color = Components::Color.new(YELLOW, BLACK, 3, false)
    Entity.new.color = Components::Color.new(CYAN, BLACK, 4, false)
    Entity.new.color = Components::Color.new(MAGENTA, BLACK, 5, false)

    status_bar = Entity.new
    status_bar.status_bar = Components::StatusBar.new(true)
    status_bar.status_bar_text = Components::StatusBarText.new("Welcome to Tactics of Nine!")

    messages_bar = Entity.new
    messages_bar.messages_bar = Components::MessagesBar.new(10)

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

    party = Entity.new
    party.name = Components::Name.new("Rex's Party")
    party.character = Components::Character.new(true)
    party.tile = Components::Tile.new("@")
    party.tile_color = Components::TileColor.new(0)
    party.position = Components::Position.new(9, 8)
    party.blocks_movement = Components::BlocksMovement.new(true)
    party.targettable = Components::Targettable.new(true)

    party.energy = Components::Energy.new(0, 100)
    party.health = Components::Health.new(10, 100)

    camera = Entity.new
    camera.camera = Components::Camera.new(true)
    camera.position = Components::Position.new(5, 7)
    camera.highlight = Components::Highlight.new(true)
  end
end
