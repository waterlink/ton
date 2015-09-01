module Ton
  new_system Pause do
    def keypress(key)
      return false unless key == ControlConstants::P
      did_something = false

      world.each_component.pausable do |pause|
        current_world = world

        Entity.new.switch_to_world = Components::SwitchToWorld.new(pause.world)
        Universe.with_world(pause.world) do
          Entity.new.paused_world = Components::PausedWorld.new(current_world)
        end

        did_something = true
      end

      did_something
    end

    def update
      world.each.unpause do |unpause|
        world.each.paused_world do |entity|
          Entity.new.switch_to_world = Components::SwitchToWorld.new(entity.paused_world!.world)
          entity.paused_world = nil
        end

        unpause.unpause = nil
      end
    end
  end
end
