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

        ai.ai_target!.value.position.bind do |position|
          target = Components::Position.new(*plus_minus_one(
            position.x,
            position.y,
          ))

          unless same_target?
            remove_movement_target

            e = Entity.new
            e.position = Components::Position.new(target.x, target.y)
            e.tile = Components::Tile.new("x")
            ai.tile_color.bind do |color|
              e.tile_color = Components::TileColor.new(color.slot)
            end
            e.low_tile = Components::LowTile.new(true)

            ai.movement_target = Components::MovementTarget.new(target.x, target.y, e)
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

            log_attack
          end
        end

        self
      end

      def set_ai_target(target)
        return if ai.ai_target? && target == ai.ai_target!.value
        ai.ai_target = Components::AiTarget.new(target)
        log_target
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
          e = x.tile
          e.position = nil
          e.tile = nil
          e.tile_color = nil
          e.low_tile = nil

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

      def same_target?
        return false unless ai.movement_target?
        return false unless ai.ai_target?
        return false unless ai.ai_target!.value.position?

        target = ai.movement_target!
        position = ai.ai_target!.value.position!
        Position.tiles(target, position) == 1
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

      def plus_minus_one(x, y)
        if rand < 0.5
          {x, y + ((rand(2)-0.5)*2).to_i}
        else
          {x + ((rand(2)-0.5)*2).to_i, y}
        end
      end

      def log_attack
        ai.name.bind do |name|
          target = ai.ai_target!.value
          target.name.bind do |target_name|
            Entity.new.message_log = Components::MessageLog.new(
              "#{name.value} attacks #{target_name.value}",
            )
          end
        end
      end

      def log_target
        ai.name.bind do |name|
          target = ai.ai_target!.value
          target.name.bind do |target_name|
            Entity.new.message_log = Components::MessageLog.new(
              "#{name.value} wants #{target_name.value} dead",
            )
          end
        end
      end
    end
  end
end
