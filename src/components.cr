module Ton
  new_component Position, x, y

  new_component Tile, value
  new_component LowTile, value
  # .slot should be > 1
  new_component Color, foreground, background, slot, initialized
  new_component TileColor, slot

  new_component Camera, value
  new_component Highlight, value
  new_component StaticCamera, value
  new_component UnstaticCamera, value

  new_component Boundaries, x, y, w, h

  new_component StatusBar, value
  new_component StatusBarText, text

  new_component MessagesBar, size
  new_component MessageLog, text

  new_component CharacterStatus, value
  new_component TargetStatus, value
  new_component Name, value
  new_component HealthStatus, value
  new_component EnergyStatus, value
  new_component ActionCostStatus, value

  new_component Character, value
  new_component SelectedCharacter, value
  new_component UnselectCharacter, value
  new_component CharacterSelectionMenu, value
  new_component Idle, value

  new_component ActSubmenu, value

  new_component Menu, name, items
  new_component MenuItem, text, active, action
  new_component ActiveMenu, value
  new_component CancelMenu, value

  new_component ActivateActSubmenu, value

  new_component FrontendWindow, value
  new_component ActiveWindow, value

  new_component MoveAction, value
  new_component MovementTarget, x, y, tile
  new_component MovementPath, waypoints
  new_component BlocksMovement, value
  new_component MovementEnergyCost, value
  new_component MovementCostEstimate, value

  new_component Damage, value
  new_component InflictedDamage, target, value

  new_component AttackAction, value
  new_component AttackEnergyCost, value
  new_component AttackRange, value
  new_component AttackCostEstimate, value
  new_component AttackTileTarget, x, y, damage
  new_component Targettable, value

  new_component Energy, current, max
  new_component EnergyRestoration, value
  new_component EnergyCost, value
  new_component EnergyCostEstimate, value

  new_component Health, current, max
  new_component Dead, value

  new_component Enemy, value
  new_component MeleeAi, value
  new_component AiTarget, value

  new_component Quit, value
  new_component SwitchToWorld, world

  new_component Pausable, world
  new_component PausedWorld, world
  new_component Unpause, value

  new_component ResetWorld, value
  new_component ResetUniverse, value

  new_component LoseWorld, world
  new_component WinWorld, world

  new_component Terrain, x, y, tw, th, lines
  new_component TerrainTile, tile, lines
  new_component TerrainSubTile, tile, value
end
