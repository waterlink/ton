module Ton
  class Rectangle
    getter width, height
    def initialize(@width, @height)
    end

    def contains?(x, y)
      x >= 0 && y >= 0 &&
        x < width && y < height
    end
  end
end
