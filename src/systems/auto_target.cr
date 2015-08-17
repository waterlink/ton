module Ton
  new_system AutoTarget do
    def keypress(key)
      return false unless key == ControlConstants::SPACE
      return false unless attack_action?
      return false unless selected_character?
      auto_target_next_enemy_in_range
    end

    def auto_target_next_enemy_in_range
      target = nil
      select_next = false
      World.each.enemy do |enemy|
        next if enemy.dead?
        next unless in_range?(enemy)

        enemy.position.bind do |position|
          target = enemy if select_next

          if Position.same_position?(position, camera.position!)
            select_next = true
          end
        end
      end

      unless target
        target = first_alive_enemy_in_range
      end

      move_camera_to(target)
    end

    def in_range?(enemy)
      result = false

      enemy.position.bind do |target|
        selected_character.position.bind do |position|
          tiles = Position.tiles(position, target)
          result = tiles > 0

          selected_character.attack_range.bind do |range|
            result &&= tiles <= range.value
          end
        end
      end

      result
    end

    def first_alive_enemy_in_range
      result = nil
      World.each.enemy do |enemy|
        next if enemy.dead?
        next unless in_range?(enemy)

        result = enemy
      end
      result
    end

    def move_camera_to(enemy)
      return false unless enemy

      enemy.position.bind do |target|
        camera.position!.x = target.x
        camera.position!.y = target.y
      end

      true
    end

    def attack_action?
      World.each.attack_action.any?
    end

    def selected_character?
      World.each.selected_character.any?
    end

    def selected_character
      World.each.selected_character.first
    end

    def camera
      World.each.camera.first
    end
  end
end
