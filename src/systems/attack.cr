module Ton
  new_system Attack do
    def update
      status.text = "Choose tile to attack" if attack_action?
      status.text = "Can't attack there. Choose another tile to attack" if attack_action? && !can_attack_there?
      status.text = "Can't attack: not enough energy" if attack_action? && !enough_energy?

      calculate_energy_cost if attack_action?
      empty_energy_cost unless attack_action?

      World.each_component.attack_tile_target do |attack|
        World.each.targettable do |targettable|
          targettable.position.bind do |position|
            if Position.same_position?(position, attack)
              attack_targettable(targettable, attack.damage)
            end
          end
        end
        attack.entity.not_nil!.attack_tile_target = nil
      end
    end

    def keypress(key)
      return false unless key == ControlConstants::ENTER
      return false unless attack_action?
      return false unless can_attack_there?
      return false unless enough_energy?
      return attack_targettable_under_camera if targettable_under_camera
      attack_tile
    end

    def attack_tile
      selected_character.damage.bind do |damage|
        Entity.new.attack_tile_target = Components::AttackTileTarget.new(
          camera.position!.x,
          camera.position!.y,
          damage.value,
        )
      end
      spend_attack_cost
      remove_attack_action
      true
    end

    def attack_targettable_under_camera
      selected_character.damage.bind do |damage|
        attack_targettable(targettable_under_camera.not_nil!, damage.value)
      end
      spend_attack_cost
      remove_attack_action
      true
    end

    def attack_targettable(entity, damage)
      Entity.new.inflicted_damage = Components::InflictedDamage.new(
        entity,
        damage,
      )
    end

    def spend_attack_cost
      selected_character.energy.bind do |energy|
        selected_character.attack_energy_cost.bind do |cost|
          new_energy = energy.current - cost.value
          energy.current = new_energy
        end
      end
    end

    def remove_attack_action
      World.each.attack_action do |e|
        e.attack_action = nil
      end

      Entity.new.unselect_character = Components::UnselectCharacter.new(true)

      status.text = ""
    end

    def enough_energy?
      result = true
      selected_character.energy.bind do |energy|
        selected_character.attack_energy_cost.bind do |cost|
          result = energy.current >= cost.value
        end
      end
      result
    end

    def attack_action?
      World.each.attack_action.any?
    end

    def calculate_energy_cost
      return unless selected_character?
      return empty_energy_cost unless can_attack_there?

      cost = 0
      selected_character.attack_energy_cost.bind do |attack_cost|
        cost = attack_cost.value
      end
      attack_cost_estimate.energy_cost = Components::EnergyCost.new(cost)
    end

    def empty_energy_cost
      return unless selected_character?
      attack_cost_estimate.energy_cost.bind do |x|
        attack_cost_estimate.energy_cost = nil
      end
    end

    def can_attack_there?
      tiles = Position.tiles(selected_character.position!, camera.position!)
      yes = tiles > 0
      selected_character.attack_range.bind do |range|
        yes = yes && tiles <= range.value
      end
      yes
    end

    def targettable_under_camera
      result = nil
      World.each.targettable do |targettable|
        targettable.position.bind do |position|
          if Position.same_position?(position, camera.position!)
            result = targettable
          end
        end
      end
      result
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

    def status
      World.each_component.status_bar_text.first
    end

    def attack_cost_estimate
      World.each.attack_cost_estimate.first
    end
  end
end
