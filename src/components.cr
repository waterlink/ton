module Ton
  new_component Position, x, y

  new_component Tile, value
  # .slot should be > 1
  new_component Color, foreground, background, slot, initialized
  new_component TileColor, slot

  new_component Camera, value
  new_component StaticCamera, value
  new_component UnstaticCamera, value

  new_component Character, value
  new_component SelectedCharacter, value
  new_component UnselectCharacter, value
  new_component CharacterSelectionMenu, value

  new_component Menu, items
  new_component MenuItem, text, active, action
  new_component ActiveMenu, value
  new_component CancelMenu, value

  new_component FrontendWindow, value
  new_component ActiveWindow, value

  new_component MoveAction, value
  new_component MovementTarget, x, y
end
