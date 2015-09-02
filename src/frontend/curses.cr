require "../curses/curses"
require "./window_wrapper"

module Ton
  module Frontend
    class Driver
      getter window
      def initialize
        @window = WindowWrapper.new(Curses.stdscr)
        Curses.crmode
        Curses.noecho
        Curses.nonl
        Curses.start_color

        Curses.init_pair(1, 0, 7)
      end

      def black_on_white
        1
      end

      def init_color(color)
        Curses.init_pair(color.slot, color.foreground, color.background)
        color.initialized = true
      end

      def set_color(pair)
        Curses.set_color(pair)
      end

      def reset_color
        set_color(0)
      end

      def set_color(w, pair)
        w.set_color(pair)
      end

      def reset_color(w)
        w.set_color(0)
      end

      def draw_tile(x, y, tile)
        window.setpos(y, x)
        window.addstr(tile)
      end

      def reset_pos
        window.setpos(0, 0)
      end

      def highlight(x, y)
        window.standout(y, x, 1, 0)
      end

      def highlight(w, x, y)
        w.standout(y + 1, x + 2, 1, 0)
      end

      def refresh
        window.refresh
      end

      def refresh(w)
        w.refresh
      end

      def new_window(x, y, w, h)
        WindowWrapper.new(
          Curses::Window.new(h, w, y, x)
        )
      end

      def box(w)
        w.box('|', '=')
      end

      def puts(x, y, text)
        window.setpos(y, x)
        window.addstr(text)
      end

      def puts(w, x, y, text)
        w.setpos(y + 1, x + 2)
        w.addstr(text)
      end

      def get_key
        ch = window.getch
        return ch if ch > -1
      end

      def get_key_sequence
        seq = [] of Int32
        while key = get_key
          seq << key
        end
        seq
      end

      def close
        Curses.close_screen
      end

      def close(w)
        w.close
      end
    end
  end
end
