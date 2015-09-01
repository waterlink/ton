module Ton
  new_system World do
    def update
      do_reset_world
      do_switch_world
    end

    def do_switch_world
      return unless switch_world?

      new_world = switch_world.switch_to_world!.world
      switch_world.switch_to_world = nil

      Universe.switch_to(new_world)
    end

    def switch_world?
      world.each.switch_to_world.any?
    end

    def switch_world
      world.each.switch_to_world.first
    end

    def do_reset_world
      return unless reset_world?
      reset_world.reset_world = nil
      world.reset
    end

    def reset_world?
      world.each.reset_world.any?
    end

    def reset_world
      world.each.reset_world.first
    end
  end
end
