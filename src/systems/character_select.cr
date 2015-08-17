module Ton
  new_system CharacterSelect do
    CONTROLS = {
      ControlConstants::ENTER => -> (s : self) { s.select_character_under_camera },
      ControlConstants::TAB => -> (s : self) { s.select_next_character },
    }

    NULL_CONTROL = -> (s : self) { false }

    def update
      World.each.unselect_character do |entity|
        World.each.selected_character do |character|
          character.selected_character = nil
        end

        entity.unselect_character = nil
      end
    end

    def keypress(key)
      CONTROLS.fetch(key, NULL_CONTROL).call(self)
    end

    def select_character_under_camera
      return if selected_character?
      did_something = false

      World.each.character do |character|
        character.position.bind do |position|
          return unless Position.same_position?(position, camera.not_nil!.position!)
          character.not_nil!.selected_character = Components::SelectedCharacter.new(true)
          did_something = true
        end
      end

      did_something
    end

    def select_next_character
      select_next = !selected_character?
      to_select = nil

      World.each.character do |character|
        to_select = character if select_next
        select_next = character.selected_character?
      end

      unless to_select
        to_select = World.each.character.first if World.each.character.any?
      end

      unselect_character

      if to_select
        to_select.selected_character = Components::SelectedCharacter.new(true)
        move_camera_to_selected_character
        return true
      end

      false
    end

    def move_camera_to_selected_character
      selected_character.position.bind do |position|
        camera.position!.x = position.x
        camera.position!.y = position.y
      end
    end

    def unselect_character
      return unless selected_character?
      selected_character.selected_character = nil
    end

    def camera
      World.each.camera.first
    end

    def selected_character?
      selected_character
      true
    rescue
      false
    end

    def selected_character
      World.each.selected_character.first
    end
  end
end
