module Ton
  new_system Energy do
    def update
      World.each.energy_restoration do |entity|
        entity.energy.bind do |energy|
          energy.current += entity.energy_restoration!.value
          energy.current = energy.max if energy.current > energy.max
        end
      end
    end
  end
end
