module Ton
  new_system TargetStatus do
    def update
      return empty unless targettable?
      fill_out_values
    end

    def draw
      w = window
      frontend.puts(w, 0, 0, " " * TargetStatusConstants::WIDTH)
      frontend.puts(w, 0, 1, " " * TargetStatusConstants::WIDTH)
      frontend.puts(w, 0, 2, " " * TargetStatusConstants::WIDTH)
      frontend.box(w)
      frontend.puts(w, 0, 0, target_status.name!.value)
      frontend.puts(w, 0, 1, target_status.health_status!.value)
      frontend.puts(w, 0, 2, target_status.energy_status!.value)
      frontend.refresh(w)
    end

    def empty
      target_status.name!.value = "---"
      target_status.health_status!.value = "---"
      target_status.energy_status!.value = "---"
    end

    def fill_out_values
      t = targettable.not_nil!
      target_status.name!.value = t.name!.value
      target_status.health_status!.value = "HP: #{t.health!.current} / #{t.health!.max}"
      target_status.energy_status!.value = "EP: #{t.energy!.current} / #{t.energy!.max}"
    end

    def window
      window = nil

      target_status.frontend_window.bind do |w|
        window = w.value
      end

      unless window
        window = frontend.new_window(
          TargetStatusConstants::LEFT,
          TargetStatusConstants::TOP,
          TargetStatusConstants::WIDTH,
          TargetStatusConstants::HEIGHT,
        )

        target_status.frontend_window = Components::FrontendWindow.new(window.not_nil!)
      end

      window.not_nil!
    end

    def targettable?
      !!targettable
    end

    def targettable
      result = nil
      World.each.targettable do |entity|
        entity.position.bind do |position|
          if Position.same_position?(position, camera.position!)
            result = entity
          end
        end
      end
      result
    end

    def target_status
      World.each.target_status.first
    end

    def camera
      World.each.camera.first
    end
  end
end
