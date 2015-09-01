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
        end
      end
    end
  end
end
