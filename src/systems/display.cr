module Ton
  new_system Display do
    def draw
      _clear_screen

      World.each.camera do |camera|
        World.each.tile do |entity|
          entity.position.bind do |position|
            x = position.x - camera.position!.x + DisplayConstants::WIDTH / 2
            y = position.y - camera.position!.y + DisplayConstants::HEIGHT / 2

            if DisplayRectangle.contains?(x, y)
              entity.tile_color.bind { |c| frontend.set_color(c.slot) }
              frontend.draw_tile(x, y, entity.tile!.value)
              frontend.reset_color
            end
          end
        end

        return
      end
    end

    def _clear_screen
      (0..DisplayConstants::HEIGHT).each do |y|
        (0..DisplayConstants::WIDTH).each do |x|
          frontend.draw_tile(x, y, DisplayConstants::EMPTY_TILE)
        end
      end
    end
  end
end
