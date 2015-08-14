require "./*"

module Curses
  extend self

  def init_screen
    @@stdscr ||= begin
      stdscr = LibCurses.initscr
      unless stdscr
        raise "Couldn't initialize ncurses"
      end
      Window.new stdscr
    end
  end

  def stdscr
    init_screen
  end

  def refresh
    LibCurses.refresh
  end

  def getch
    LibCurses.getch
  end

  def crmode
    LibCurses.cbreak
  end

  def noecho
    LibCurses.noecho
  end

  def nonl
    LibCurses.nonl
  end

  def start_color
    LibCurses.start_color
  end

  def init_pair(p, f, b)
    LibCurses.init_pair(p.to_i16, f.to_i16, b.to_i16)
  end

  def set_color(p)
    LibCurses.color_set(p.to_i16, nil)
  end

  def lines
    LibCurses.lines
  end

  def cols
    LibCurses.cols
  end

  def setpos(x, y)
    LibCurses.move(x, y)
  end

  def addstr(str)
    LibCurses.addstr str
  end

  def close_screen
    LibCurses.endwin
  end
end
