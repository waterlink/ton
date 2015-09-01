module Ton
  new_system Damage do
    def update
      world.each.inflicted_damage do |e|
        e.inflicted_damage!.target.health.bind do |health|
          new_health = health.current - e.inflicted_damage!.value
          health.current = new_health

          log_damage(health.entity.not_nil!, e.inflicted_damage!.value)
        end
        e.inflicted_damage = nil
      end
    end

    def log_damage(target, damage)
      target.name.bind do |name|
        Entity.new.message_log = Components::MessageLog.new(
          "#{name.value} receives #{damage} DMG",
        )
      end
    end
  end
end
