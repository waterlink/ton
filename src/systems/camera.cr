module Ton
  new_system Camera do
    CONTROLS = {
      ControlConstants::UP => (-> (s : self) { s.up }),
      ControlConstants::DOWN => (-> (s : self) { s.down }),
      ControlConstants::LEFT => (-> (s : self) { s.left }),
      ControlConstants::RIGHT => (-> (s : self) { s.right }),
    }

    NULL_CONTROL = -> (s : self) { false }

    def draw
      return if static?

      World.each.camera do |camera|
        frontend.highlight(
          DisplayConstants::WIDTH / 2 + DisplayConstants::LEFT,
          DisplayConstants::HEIGHT / 2 + DisplayConstants::TOP,
        )

        return
      end
    end

    def update
      World.each.unstatic_camera do |action|
        World.each.static_camera do |entity|
          entity.static_camera = nil
        end

        action.unstatic_camera = nil
      end
    end

    def keypress(key)
      return if static?
      return unless camera?

      did_something = CONTROLS.fetch(key, NULL_CONTROL).call(self)
      handle_possible_shift_sequence(key)
      did_something
    end

    def up
      camera.position!.y -= shift_pressed? ? 5 : 1
      true
    end

    def down
      camera.position!.y += shift_pressed? ? 5 : 1
      true
    end

    def left
      camera.position!.x -= shift_pressed? ? 5 : 1
      true
    end

    def right
      camera.position!.x += shift_pressed? ? 5 : 1
      true
    end

    def handle_possible_shift_sequence(key)
      return reset_shift_sequence unless in_shift_sequence?(key)
      advance_shift_sequence
    end

    def static?
      is_static = false
      World.each.static_camera do |c|
        is_static = true
      end
      is_static
    end

    def camera?
      World.each.camera.any?
    end

    def camera
      World.each.camera.first
    end

    def shift_pressed?
      shift_sequence_index == ControlConstants::SHIFT_SEQUENCE.count
    end

    def in_shift_sequence?(key)
      reset_shift_sequence if shift_pressed?
      key == ControlConstants::SHIFT_SEQUENCE[shift_sequence_index]
    end

    def shift_sequence_index
      (@_shift_sequence_index ||= 0).not_nil!
    end

    def advance_shift_sequence
      @_shift_sequence_index = shift_sequence_index + 1
    end

    def reset_shift_sequence
      @_shift_sequence_index = 0
    end
  end
end
