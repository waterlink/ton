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

    def self.simple_next_position(position, target)
      if position.x != target.x
        return Components::Position.new(
          position.x + sign(target.x - position.x),
          position.y,
        )
      end

      if position.y != target.y
        return Components::Position.new(
          position.x,
          position.y + sign(target.y - position.y),
        )
      end

      return position
    end

    def self.sign(x)
      x / x.abs
    end
  end
end
