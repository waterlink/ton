module Ton
  new_system Death do
    def update
      World.each.health do |e|
        if e.health!.current <= 0
          # FIXME: very primitive version of death used
          e.position.bind do |x|
            e.position = nil
          end
        end
      end
    end
  end
end
