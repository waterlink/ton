module Ton
  new_system TurnFlow do
    def update
      show_character_selection_menu if selected_character_is_idle
    end

    def show_character_selection_menu
      return if character_selection_menu.active_menu?
      character_selection_menu.active_menu = Components::ActiveMenu.new(true)
    end

    def selected_character_is_idle
      return false unless selected_character?
      [
        !move_action?,
        !selected_character.movement_target?,
      ].all?
    end

    def selected_character?
      World.each.selected_character.any?
    end

    def selected_character
      World.each.selected_character.first
    end

    def move_action?
      World.each.move_action.any?
    end

    def character_selection_menu
      World.each.character_selection_menu.first
    end
  end
end
