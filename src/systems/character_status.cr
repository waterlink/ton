module Ton
  new_system CharacterStatus do
    def update
      return empty unless selected_character?
      fill_out_values
    end

    def draw
      w = window
      frontend.puts(w, 0, 0, " " * CharacterStatusConstants::WIDTH)
      frontend.puts(w, 0, 1, " " * CharacterStatusConstants::WIDTH)
      frontend.puts(w, 0, 2, " " * CharacterStatusConstants::WIDTH)
      frontend.puts(w, 0, 3, " " * CharacterStatusConstants::WIDTH)
      frontend.box(w)
      frontend.puts(w, 0, 0, character_status.name!.value)
      frontend.puts(w, 0, 1, character_status.health_status!.value)
      frontend.puts(w, 0, 2, character_status.energy_status!.value)
      frontend.puts(w, 0, 3, character_status.action_cost_status!.value)
      frontend.refresh(w)
    end

    def empty
      character_status.name!.value = "---"
      character_status.health_status!.value = "---"
      character_status.energy_status!.value = "---"
      character_status.action_cost_status!.value = "---"
    end

    def fill_out_values
      character_status.name!.value = selected_character.name!.value
      character_status.health_status!.value = "HP: #{selected_character.health!.current} / #{selected_character.health!.max}"
      character_status.energy_status!.value = "EP: #{selected_character.energy!.current} / #{selected_character.energy!.max}"

      energy_cost = "---"
      selected_character.energy_cost_estimate.bind { |e| energy_cost = e.value.to_s }
      character_status.action_cost_status!.value = "COST: #{energy_cost} EP"
    end

    def selected_character?
      selected_character
      true
    rescue
      false
    end

    def selected_character
      World.each.selected_character.first
    end

    def character_status
      World.each.character_status.first
    end

    def window
      window = nil

      character_status.frontend_window.bind do |w|
        window = w.value
      end

      unless window
        window = frontend.new_window(
          CharacterStatusConstants::LEFT,
          CharacterStatusConstants::TOP,
          CharacterStatusConstants::WIDTH,
          CharacterStatusConstants::HEIGHT,
        )

        character_status.frontend_window = Components::FrontendWindow.new(window.not_nil!)
      end

      window.not_nil!
    end
  end
end
