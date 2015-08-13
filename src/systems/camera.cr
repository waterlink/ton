module Ton
  new_system Camera do
    def draw
      World.each.camera do |camera|
        frontend.highlight(
          DisplayConstants::WIDTH / 2,
          DisplayConstants::HEIGHT / 2,
        )

        return
      end
    end

    # Follow player by default
    def update
      World.each.camera do |camera|
        World.each.player do |player|
          player.position.bind do |position|
            camera.position!.x = position.x
            camera.position!.y = position.y
          end
        end

        return
      end
    end
  end
end
