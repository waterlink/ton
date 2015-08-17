module Ton
  module DisplayConstants
    LEFT = 0
    TOP = 4
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
    TAB = 9

    # TODO: verify if it is the same for all platforms and terminals
    SHIFT_SEQUENCE = [27, 91, 49, 59, 50]
  end

  module StatusBarConstants
    LEFT = 0
    TOP = 0
    WIDTH = DisplayConstants::WIDTH
    HEIGHT = DisplayConstants::TOP
  end

  module CharacterStatusConstants
    LEFT = DisplayConstants::WIDTH
    TOP = 0
    WIDTH = 20
    HEIGHT = 6
  end

  DisplayRectangle = Rectangle.new(
    DisplayConstants::WIDTH,
    DisplayConstants::HEIGHT,
  )
end
