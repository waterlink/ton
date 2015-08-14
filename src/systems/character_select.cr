module Ton
  new_system CharacterSelect do
    SPACE = 32

    def keypress(key)
      return unless key == SPACE
      return if selected_character

      character.not_nil!.position.bind do |position|
        return unless same_position?(position, camera.not_nil!.position!)
        character.not_nil!.selected_character = Components::SelectedCharacter.new(true)
        menu.active_menu = Components::ActiveMenu.new(true)
      end
    end

    def character
      World.each.character.first
    end

    def camera
      World.each.camera.first
    end

    def menu
      World.each.character_selection_menu.first
    end

    def selected_character
      character = nil
      World.each.selected_character do |c|
        character = c
      end
      character
    end

    def same_position?(a, b)
      a.x == b.x && a.y == b.y
    end
  end
end
