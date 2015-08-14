module Ton
  module DisplayConstants
    WIDTH = 50
    HEIGHT = 20
    EMPTY_TILE = "."
  end

  module ControlConstants
    UP = 65
    DOWN = 66
    LEFT = 68
    RIGHT = 67
    ENTER = 13
  end

  DisplayRectangle = Rectangle.new(
    DisplayConstants::WIDTH,
    DisplayConstants::HEIGHT,
  )
end
