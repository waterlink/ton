module Ton
  new_system Movement do
    def draw
      return unless move_action?

      # FIXME: should be in some sort of status bar
      frontend.puts(1, 1, "Choose position to move")
    end

    def update
      World.each.movement_target do |entity|
        entity.position.bind do |position|
          new_position = next_position(position, entity.movement_target!)

          if Position.same_position?(position, new_position)
            entity.movement_target = nil
          else
            position.x = new_position.x
            position.y = new_position.y
          end
        end
      end
    end

    def keypress(key)
      return false unless key == ControlConstants::ENTER
      return false unless move_action?
      return false unless selected_character?

      set_movement_target
      remove_move_action
      true
    end

    def next_position(position, target)
      if position.x != target.x
        return Components::Position.new(
          position.x + sign(target.x - position.x),
          position.y,
        )
      end

      if position.y != target.y
        return Components::Position.new(
          position.x,
          position.y + sign(target.y - position.y),
        )
      end

      return position
    end

    def sign(x)
      x / x.abs
    end

    def move_action?
      yes = false
      World.each.move_action { |a| yes = true }
      yes
    end

    def remove_move_action
      World.each.move_action &.move_action = nil
    end

    def selected_character?
      yes = false
      World.each.selected_character { |c| yes = true }
      yes
    end

    def set_movement_target
      selected_character.movement_target = Components::MovementTarget.new(
        camera.position!.x,
        camera.position!.y,
      )
    end

    def selected_character
      World.each.selected_character.first
    end

    def camera
      World.each.camera.first
    end
  end
end