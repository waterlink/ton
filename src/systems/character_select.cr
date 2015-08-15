module Ton
  new_system CharacterSelect do
    def update
      World.each.unselect_character do |entity|
        World.each.selected_character do |character|
          character.selected_character = nil
        end

        entity.unselect_character = nil
      end
    end

    def keypress(key)
      return unless key == ControlConstants::ENTER
      return if selected_character
      did_something = false

      character.not_nil!.position.bind do |position|
        return unless Position.same_position?(position, camera.not_nil!.position!)
        character.not_nil!.selected_character = Components::SelectedCharacter.new(true)
        did_something = true
      end

      did_something
    end

    def character
      World.each.character.first
    end

    def camera
      World.each.camera.first
    end

    def selected_character
      character = nil
      World.each.selected_character do |c|
        character = c
      end
      character
    end
  end
end
