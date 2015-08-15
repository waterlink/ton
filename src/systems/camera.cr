module Ton
  new_system Camera do
    CONTROLS = {
      ControlConstants::UP => (-> (c : Entity) { c.position!.y -= 1; true }),
      ControlConstants::DOWN => (-> (c : Entity) { c.position!.y += 1; true }),
      ControlConstants::LEFT => (-> (c : Entity) { c.position!.x -= 1; true }),
      ControlConstants::RIGHT => (-> (c : Entity) { c.position!.x += 1; true }),
    }

    NULL_CONTROL = -> (c : Entity) { false }

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
      World.each.unstatic_camera do |action|
        World.each.static_camera do |entity|
          entity.static_camera = nil
        end

        action.unstatic_camera = nil
      end
    end

    def keypress(key)
      return if static?
      did_something = false

      World.each.camera do |camera|
        did_something ||= CONTROLS.fetch(key, NULL_CONTROL).call(camera)
      end

      did_something
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
