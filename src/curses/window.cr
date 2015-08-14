struct Curses::Window
  def self.new(height, width, top, left)
    new LibCurses.newwin(height, width, top, left)
  end

  def initialize(@unwrap : LibCurses::Window)
  end

  def box(vert : Char, hor : Char)
    LibCurses.box self, vert.ord, hor.ord
  end

  def setpos(x, y)
    LibCurses.wmove self, x, y
  end

  def set_color(p)
    LibCurses.wcolor_set(self, p.to_i16, nil)
  end

  def addstr(str)
    LibCurses.waddstr self, str
  end

  def getch
    LibCurses.wgetch self
  end

  def refresh
    LibCurses.wrefresh self
  end

  def close
    LibCurses.delwin self
  end

  def to_unsafe
    @unwrap
  end
end
