module Ton
  new_system Camera do
    CONTROLS = {
      ControlConstants::UP => (-> (s : self) { s.up }),
      ControlConstants::DOWN => (-> (s : self) { s.down }),
      ControlConstants::LEFT => (-> (s : self) { s.left }),
      ControlConstants::RIGHT => (-> (s : self) { s.right }),

      ControlConstants::SHIFT_UP => (-> (s : self) { s.up(5) }),
      ControlConstants::SHIFT_DOWN => (-> (s : self) { s.down(5) }),
      ControlConstants::SHIFT_LEFT => (-> (s : self) { s.left(5) }),
      ControlConstants::SHIFT_RIGHT => (-> (s : self) { s.right(5) }),
    }

    NULL_CONTROL = -> (s : self) { false }

    def draw
      return if static?
      return unless World.each.camera.any?
      frontend.highlight(
        DisplayConstants::WIDTH / 2 + DisplayConstants::LEFT,
        DisplayConstants::HEIGHT / 2 + DisplayConstants::TOP,
      )
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
      did_something
    end

    def up(value=1)
      camera.position!.y -= value
      true
    end

    def down(value=1)
      camera.position!.y += value
      true
    end

    def left(value=1)
      camera.position!.x -= value
      true
    end

    def right(value=1)
      camera.position!.x += value
      true
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
  end
end
