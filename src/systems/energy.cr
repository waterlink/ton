module Ton
  new_system Energy do
    def update
      handle_restoration
      handle_cost_estimates
    end

    def handle_restoration
      World.each.energy_restoration do |entity|
        entity.energy.bind do |energy|
          energy.current += entity.energy_restoration!.value
          energy.current = energy.max if energy.current > energy.max
        end
      end
    end

    def handle_cost_estimates
      return empty_cost_estimate unless selected_character?

      total_cost = 0
      World.each_component.energy_cost do |cost|
        total_cost += cost.value
      end

      update_cost_estimate(total_cost)
    end

    def update_cost_estimate(total_cost)
      return empty_cost_estimate if total_cost == 0
      selected_character.energy_cost_estimate = Components::EnergyCostEstimate.new(total_cost)
    end

    def empty_cost_estimate
      World.each.energy_cost_estimate do |e|
        e.energy_cost_estimate = nil
      end
    end

    def selected_character?
      World.each.selected_character.any?
    end

    def selected_character
      World.each.selected_character.first
    end
  end
end
