module Ton
  new_system Death do
    def update
      world.each.health do |e|
        if !e.dead? && e.health!.current <= 0
          # FIXME: very primitive version of death used
          e.position.bind do |x|
            e.position = nil
          end

          e.dead = Components::Dead.new(true)
          log_death(e)
        end
      end
    end

    def log_death(entity)
      entity.name.bind do |name|
        Entity.new.message_log = Components::MessageLog.new(
          "#{name.value} dies",
        )
      end
    end
  end
end
