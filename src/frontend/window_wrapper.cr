module Ton
  module Frontend
    class WindowWrapper
      def initialize(@window)
        @closed = false
      end

      def close
        @window.close
        @closed = true
      end

      macro method_missing(name, args, block)
        if @closed
          Logger.error "Trying to use closed window, ignoring."
          Logger.debug caller
          return
        end

        @window.{{name.id}}({{args.argify}}) {{block}}
      end
    end
  end
end
