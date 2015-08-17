module Ton
  module Position
    def self.same_position?(a, b)
      a.x == b.x && a.y == b.y
    end

    def self.tiles(a, b)
      [a.x - b.x, a.y - b.y]
        .map(&.abs)
        .sum
    end
  end
end
