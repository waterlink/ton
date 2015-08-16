module Ton
  new_system Movement do
    def update
      status.text = "Choose position to move" if move_action?
      calculate_energy_cost if move_action?
      empty_energy_cost unless move_action?

      World.each.movement_target do |entity|
        entity.position.bind do |position|
          new_position = next_position(position, entity.movement_target!)

          if Position.same_position?(position, new_position)
            entity.movement_target = nil
          else
            can_move = true
            entity.movement_energy_cost.bind do |cost|
              entity.energy.bind do |energy|
                can_move = energy.current >= cost.value
                energy.current -= cost.value if can_move
              end
            end

            if can_move
              position.x = new_position.x
              position.y = new_position.y
            end
          end
        end
      end
    end

    def keypress(key)
      return false unless key == ControlConstants::ENTER
      return false unless move_action?
      return false unless selected_character?
      return false unless can_move_there?

      set_movement_target
      remove_move_action
      unselect_character
      status.text = ""
      true
    end

    def calculate_energy_cost
      return unless selected_character?
      empty_energy_cost unless can_move_there?
      cost = 0
      selected_character.movement_energy_cost.bind do |movement_cost|
        tiles = (selected_character.position!.x - camera.position!.x).abs
        tiles += (selected_character.position!.y - camera.position!.y).abs
        cost = tiles * movement_cost.value
      end
      selected_character.energy_cost = Components::EnergyCost.new(cost)
    end

    def empty_energy_cost
      return unless selected_character?
      selected_character.energy_cost.bind do |x|
        selected_character.energy_cost = nil
      end
    end

    def can_move_there?
      no = false
      World.each.blocks_movement do |blocker|
        blocker.position.bind do |position|
          no ||= Position.same_position?(position, camera.position!)
        end
      end
      !no
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

    def unselect_character
      World.each.selected_character do |character|
        character.selected_character = nil
      end
    end

    def selected_character
      World.each.selected_character.first
    end

    def camera
      World.each.camera.first
    end

    def status
      World.each_component.status_bar_text.first
    end
  end
end
