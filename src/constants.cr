module Ton
  module DisplayConstants
    LEFT = 0
    TOP = 4
    WIDTH = 50
    HEIGHT = 20
    EMPTY_TILE = "."
  end

  module ControlConstants
    UP = [27, 91, 65]
    DOWN = [27, 91, 66]
    LEFT = [27, 91, 68]
    RIGHT = [27, 91, 67]

    SHIFT_UP = [27, 91, 49, 59, 50, 65]
    SHIFT_DOWN = [27, 91, 49, 59, 50, 66]
    SHIFT_LEFT = [27, 91, 49, 59, 50, 68]
    SHIFT_RIGHT = [27, 91, 49, 59, 50, 67]

    ENTER = [13]
    TAB = [9]
    ESC = [27]
    SPACE = [32]

    P = [112]

    NUM0 = [48]
    NUM1 = [49]
    NUM2 = [50]
    NUM3 = [51]
    NUM4 = [52]
    NUM5 = [53]
    NUM6 = [54]
    NUM7 = [55]
    NUM8 = [56]
    NUM9 = [57]
  end

  module StatusBarConstants
    LEFT = 0
    TOP = 0
    WIDTH = DisplayConstants::WIDTH
    HEIGHT = DisplayConstants::TOP
  end

  module MessagesBarConstants
    LEFT = 0
    TOP = DisplayConstants::TOP + DisplayConstants::HEIGHT
    WIDTH = DisplayConstants::WIDTH
  end

  module CharacterStatusConstants
    LEFT = DisplayConstants::WIDTH
    TOP = 0
    WIDTH = 20
    HEIGHT = 6
  end

  module TargetStatusConstants
    LEFT = DisplayConstants::WIDTH
    TOP = CharacterStatusConstants::HEIGHT + 2
    WIDTH = 20
    HEIGHT = 5
  end

  module MenuConstants
    LEFT = DisplayConstants::WIDTH
    TOP = TargetStatusConstants::TOP + TargetStatusConstants::HEIGHT + 2
    WIDTH = 20
    HEIGHT = 10
  end

  DisplayRectangle = Rectangle.new(
    DisplayConstants::WIDTH,
    DisplayConstants::HEIGHT,
  )
end
