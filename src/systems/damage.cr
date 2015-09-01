module Ton
  new_system Damage do
    def update
      world.each.inflicted_damage do |e|
        e.inflicted_damage!.target.health.bind do |health|
          new_health = health.current - e.inflicted_damage!.value
          health.current = new_health
        end
        e.inflicted_damage = nil
      end
    end
  end
end
