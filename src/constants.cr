module Ton
  module DisplayConstants
    WIDTH = 50
    HEIGHT = 20
    EMPTY_TILE = "."
  end

  DisplayRectangle = Rectangle.new(
    DisplayConstants::WIDTH,
    DisplayConstants::HEIGHT,
  )
end
