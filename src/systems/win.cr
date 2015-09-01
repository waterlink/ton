module Ton
  new_system Win do
    def update
      return unless win_world?
      return unless win?

      Entity.new.switch_to_world =
        Components::SwitchToWorld.new(win_world)
    end

    def win_world?
      world.each.win_world.any?
    end

    def win_world
      world.each.win_world.first.win_world!.world
    end

    def win?
      world.each.enemy.all? &.dead?
    end
  end
end
