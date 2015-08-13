module Ton
  new_system Display do
    WIDTH = 50
    HEIGHT = 20
    EMPTY_TILE = "."

    def draw
      _clear_screen
      World.each.tile do |entity|
        entity.position.bind do |position|
          frontend.draw_tile(position.x, position.y, entity.tile!.value)
        end
      end
    end

    def _clear_screen
      (0..HEIGHT).each do |y|
        (0..WIDTH).each do |x|
          frontend.draw_tile(x, y, EMPTY_TILE)
        end
      end
    end
  end
end
