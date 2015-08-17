module Ton
  new_system CharacterSelect do
    CONTROLS = {
      ControlConstants::ENTER => -> (s : self) { s.select_character_under_camera },
      ControlConstants::TAB => -> (s : self) { s.select_next_character },
    }

    NULL_CONTROL = -> (s : self) { false }

    def update
      unselect_dead_character

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

    def unselect_dead_character
      return if unselect_character?
      return unless selected_character?
      return unless selected_character.dead?

      Entity.new.unselect_character = Components::UnselectCharacter.new(true)
    end

    def select_character_under_camera
      return false if selected_character?
      return false unless character_under_camera

      character = character_under_camera.not_nil!
      character.selected_character = Components::SelectedCharacter.new(true)
      true
    end

    def character_under_camera
      result = nil
      World.each.character do |character|
        character.position.bind do |position|
          return unless Position.same_position?(position, camera.not_nil!.position!)
          result = character
        end
      end
      result
    end

    def select_next_character
      select_next = !selected_character?
      to_select = nil

      World.each.character do |character|
        if !character.dead? && character.idle?
          to_select = character if select_next
          select_next = character.selected_character? || character == character_under_camera
        end
      end

      unless to_select
        to_select = first_idle_character
      end

      if to_select
        unselect_character
        move_camera_to(to_select)
        return true
      end

      false
    end

    def move_camera_to(character)
      character.position.bind do |position|
        camera.position!.x = position.x
        camera.position!.y = position.y
      end
    end

    def first_idle_character
      result = nil
      World.each.character do |character|
        result ||= character if character.idle?
      end
      result
    end

    def unselect_character
      return false unless selected_character?
      selected_character.selected_character = nil
      true
    end

    def camera
      World.each.camera.first
    end

    def selected_character?
      World.each.selected_character.any?
    end

    def selected_character
      World.each.selected_character.first
    end

    def unselect_character?
      World.each.unselect_character.any?
    end
  end
end
