module Ton
  new_system Movement do
    def update
      remove_move_action if move_action? && !selected_character?

      status.text = "Choose position to move" if move_action?
      status.text = "Can't move there. Choose another position to move" if !can_move_there? && move_action?
      calculate_energy_cost if move_action?
      empty_energy_cost unless move_action?

      world.each.movement_target do |entity|
        entity.position.bind do |position|
          new_position = Position.simple_next_position(
            position,
            entity.movement_target!,
          )

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
      true
    end

    def calculate_energy_cost
      return unless selected_character?
      empty_energy_cost unless can_move_there?
      cost = 0
      selected_character.movement_energy_cost.bind do |movement_cost|
        selected_character.position.bind do |position|
          tiles = Position.tiles(position, camera.position!)
          cost = tiles * movement_cost.value
        end
      end
      movement_cost_estimate.energy_cost = Components::EnergyCost.new(cost)
    end

    def empty_energy_cost
      return unless selected_character?
      movement_cost_estimate.energy_cost.bind do |x|
        movement_cost_estimate.energy_cost = nil
      end
    end

    def can_move_there?
      no = false
      world.each.blocks_movement do |blocker|
        blocker.position.bind do |position|
          no ||= Position.same_position?(position, camera.position!)
        end
      end
      !no
    end

    def move_action?
      yes = false
      world.each.move_action { |a| yes = true }
      yes
    end

    def remove_move_action
      world.each.move_action &.move_action = nil
      status.text = ""
    end

    def selected_character?
      yes = false
      world.each.selected_character { |c| yes = true }
      yes
    end

    def set_movement_target
      selected_character.movement_target = Components::MovementTarget.new(
        camera.position!.x,
        camera.position!.y,
      )
    end

    def unselect_character
      world.each.selected_character do |character|
        character.selected_character = nil
      end
    end

    def selected_character
      world.each.selected_character.first
    end

    def camera
      world.each.camera.first
    end

    def status
      world.each_component.status_bar_text.first
    end

    def movement_cost_estimate
      world.each.movement_cost_estimate.first
    end
  end
end
