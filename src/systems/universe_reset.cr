module Ton
  new_system UniverseReset do
    def update
      return unless reset_universe?
      reset_universe.reset_universe = nil
      Universe.reset
    end

    def reset_universe?
      world.each.reset_universe.any?
    end

    def reset_universe
      world.each.reset_universe.first
    end
  end
end
