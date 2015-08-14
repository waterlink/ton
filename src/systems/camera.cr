module Ton
  new_system Camera do
    CONTROLS = {
      ControlConstants::UP => (-> (c : Entity) { c.position!.y -= 1; nil }),
      ControlConstants::DOWN => (-> (c : Entity) { c.position!.y += 1; nil }),
      ControlConstants::LEFT => (-> (c : Entity) { c.position!.x -= 1; nil }),
      ControlConstants::RIGHT => (-> (c : Entity) { c.position!.x += 1; nil }),
    }

    NULL_CONTROL = -> (c : Entity) { nil }

    def draw
      return if static?

      World.each.camera do |camera|
        frontend.highlight(
          DisplayConstants::WIDTH / 2,
          DisplayConstants::HEIGHT / 2,
        )

        return
      end
    end

    def update
    end

    def keypress(key)
      return if static?

      World.each.camera do |camera|
        CONTROLS.fetch(key, NULL_CONTROL).call(camera)
      end
    end

    def static?
      is_static = false
      World.each.static_camera do |c|
        is_static = true
      end
      is_static
    end
  end
end
