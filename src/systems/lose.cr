module Ton
  new_system Lose do
    def update
      return unless lose_world?
      return unless lost?

      Entity.new.switch_to_world =
        Components::SwitchToWorld.new(lose_world)
    end

    def lose_world?
      world.each.lose_world.any?
    end

    def lose_world
      world.each.lose_world.first.lose_world!.world
    end

    def lost?
      world.each.character.all? &.dead?
    end
  end
end
