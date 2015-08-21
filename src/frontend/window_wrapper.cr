module Ton
  module Frontend
    class WindowWrapper
      getter current_pos
      def initialize(@window)
        @closed = false
        @current_pos = [0, 0]
      end

      def close
        @window.close
        @closed = true
      end

      def setpos(x, y)
        @window.setpos(x, y)
        @current_pos = [x, y]
      end

      def getch
        _default(-1) do
          @window.getch
        end
      end

      macro method_missing(name, args, block)
        _default(nil) do
          @window.{{name.id}}({{args.argify}}) {{block}}
        end
      end

      def _default(value)
        if @closed
          Logger.error "Trying to use closed window, ignoring."
          Logger.debug caller
          return value
        end

        yield
      end
    end
  end
end
