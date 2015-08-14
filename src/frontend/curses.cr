require "../curses/curses"

module Ton
  module Frontend
    class Driver
      getter window
      def initialize
        @window = Curses.stdscr
        Curses.crmode
        Curses.noecho
        Curses.nonl
        Curses.start_color
      end

      def draw_tile(x, y, tile)
        window.setpos(y, x)
        window.addstr(tile)
      end

      def highlight(x, y)
        window.setpos(y, x)
      end

      def refresh
        window.refresh
      end

      def get_key
        ch = window.getch
        return ch if ch > -1
      end
    end
  end
end
