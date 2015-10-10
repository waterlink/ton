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
      return unless camera?
      return unless camera.highlight?

      frontend.highlight(
        DisplayConstants::WIDTH / 2 + DisplayConstants::LEFT,
        DisplayConstants::HEIGHT / 2 + DisplayConstants::TOP,
      )
    end

    def update
      world.each.unstatic_camera do |action|
        world.each.static_camera do |entity|
          entity.static_camera = nil
        end

        action.unstatic_camera = nil
      end

      restore_camera
    end

    def keypress(key)
      return if static?
      return unless camera?

      did_something = CONTROLS.fetch(key, NULL_CONTROL).call(self)
      restore_camera
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

    def restore_camera
      return unless boundaries?

      camera.position!.x = [camera.position!.x, boundaries.x].max
      camera.position!.y = [camera.position!.y, boundaries.y].max
      camera.position!.x = [camera.position!.x, boundaries.x + boundaries.w - 1].min
      camera.position!.y = [camera.position!.y, boundaries.y + boundaries.h - 1].min
    end

    def static?
      is_static = false
      world.each.static_camera do |c|
        is_static = true
      end
      is_static
    end

    def camera?
      world.each.camera.any?
    end

    def camera
      world.each.camera.first
    end

    def boundaries?
      world.each_component.boundaries.any?
    end

    def boundaries
      world.each_component.boundaries.first
    end
  end
end
