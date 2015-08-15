module Ton
  module Position
    def self.same_position?(a, b)
      a.x == b.x && a.y == b.y
    end
  end
end
