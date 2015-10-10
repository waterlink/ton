module Ton
  new_system Movement do
    def update
      remove_move_action if move_action? && !selected_character?

      status.text = "Choose position to move" if move_action?
      status.text = "Can't move there. Choose another position to move" if !can_move_there? && move_action?
      calculate_energy_cost if move_action?
      empty_energy_cost unless move_action?

      world.each.movement_path do |entity|
        entity.position.bind do |position|
          new_position = entity.movement_path!.waypoints.shift

          if something_blocking_at?(new_position)
            clear_movement_target(entity)
          elsif Position.same_position?(position, new_position)
            clear_movement_target(entity)
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
            else
              entity.movement_path!.waypoints.unshift(new_position)
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
      e = Entity.new
      e.position = Components::Position.new(
        camera.position!.x,
        camera.position!.y,
      )
      e.tile = Components::Tile.new("x")
      selected_character.tile_color.bind do |color|
        e.tile_color = Components::TileColor.new(color.slot)
      end
      e.low_tile = Components::LowTile.new(true)

      selected_character.movement_target = Components::MovementTarget.new(
        camera.position!.x,
        camera.position!.y,
        e,
      )
    end

    def clear_movement_target(e)
      tile = e.movement_target!.tile
      if tile
        tile.position = nil
        tile.tile = nil
        tile.tile_color = nil
        tile.blocks_movement = nil
        tile.low_tile = nil
      end
      e.movement_target = nil
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

    def something_blocking_at?(position)
      yes = false

      world.each.blocks_movement do |entity|
        entity.position.bind do |other_position|
          yes = true if Position.same_position?(position, other_position)
        end

        break if yes
      end

      yes
    end
  end
end
