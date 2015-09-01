module Ton
  new_system MeleeAi do
    def update
      world.each.melee_ai do |ai|
        AI.new(world, ai)
          .setup_target
          .follow
          .attack
      end
    end

    class AI
      getter world, ai
      def initialize(@world, @ai)
      end

      # NOTE: Targets closest alive character
      # Possible improvement: target character who did most damage so far
      def setup_target
        best_target = first_alive_character

        return self unless alive?
        return self unless best_target

        best_tiles = Position.tiles(best_target.position!, ai.position!)
        world.each.character do |character|
          unless character.dead?
            tiles = Position.tiles(character.position!, ai.position!)
            if tiles < best_tiles
              best_tiles = tiles
              best_target = character
            end
          end
        end

        set_ai_target(best_target.not_nil!)
        self
      end

      def follow
        return self unless alive?
        return self unless target_alive?
        return remove_movement_target if in_attack_range?

        ai.ai_target!.value.position.bind do |target|
          unless same_target?(target)
            ai.movement_target = Components::MovementTarget.new(
              target.x,
              target.y,
            )
          end
        end

        self
      end

      def attack
        return self unless alive?
        return self unless target_alive?
        return self unless in_attack_range?
        return self unless enough_energy?

        ai.damage.bind do |damage|
          ai.ai_target!.value.position.bind do |target|
            spend_energy
            Entity.new.attack_tile_target = Components::AttackTileTarget.new(
              target.x,
              target.y,
              damage.value,
            )
          end
        end

        self
      end

      def set_ai_target(target)
        return if ai.ai_target? && target == ai.ai_target!.value
        ai.ai_target = Components::AiTarget.new(target)
      end

      def spend_energy
        ai.energy.bind do |energy|
          ai.attack_energy_cost.bind do |cost|
            new_energy = energy.current - cost.value
            energy.current = new_energy
          end
        end
      end

      def remove_movement_target
        ai.movement_target.bind do |x|
          ai.movement_target = nil
        end
        self
      end

      def enough_energy?
        result = true
        ai.energy.bind do |energy|
          ai.attack_energy_cost.bind do |cost|
            result = energy.current >= cost.value
          end
        end
        result
      end

      def same_target?(target)
        return false unless ai.movement_target?
        Position.same_position?(ai.movement_target!, target)
      end

      def alive?
        !ai.dead?
      end

      def first_alive_character
        result = nil
        world.each.character do |character|
          result ||= character unless character.dead?
        end
        result
      end

      def target_alive?
        return false unless ai.ai_target?
        !ai.ai_target!.value.dead?
      end

      def in_attack_range?
        result = false
        ai.ai_target!.value.position.bind do |target|
          tiles = Position.tiles(target, ai.position!)
          result = tiles > 0

          ai.attack_range.bind do |range|
            result &&= tiles <= range.value
          end
        end
        result
      end
    end
  end
end
