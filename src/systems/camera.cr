module Ton
  new_system Camera do
    UP = 65
    DOWN = 66
    LEFT = 68
    RIGHT = 67

    CONTROLS = {
      UP => (-> (c : Entity) { c.position!.y -= 1; nil }),
      DOWN => (-> (c : Entity) { c.position!.y += 1; nil }),
      LEFT => (-> (c : Entity) { c.position!.x -= 1; nil }),
      RIGHT => (-> (c : Entity) { c.position!.x += 1; nil }),
    }

    NULL_CONTROL = -> (c : Entity) { nil }

    def draw
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
      World.each.camera do |camera|
        CONTROLS.fetch(key, NULL_CONTROL).call(camera)
        return
      end
    end
  end
end
