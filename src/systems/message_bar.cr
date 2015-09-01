module Ton
  new_system MessageBar do
    def draw
      world.each.messages_bar do |messages_bar|
        size = messages_bar.messages_bar!.size
        logs_to_draw = logs(size)

        DrawMessageBar
          .new(world, frontend, messages_bar, size, logs_to_draw)
          .call
      end
    end

    def logs(size)
      logs_count = world.each.message_log.count
      start = -[logs_count, size].min
      world.each.message_log.to_a[start..-1]
    end

    class DrawMessageBar
      getter world, frontend, entity, size, logs
      def initialize(@world, @frontend, @entity, @size, @logs)
      end

      def call
        clear
        frontend.box(window)
        frontend.puts(window, 0, 0, " == Messages ==")
        logs.each_with_index do |log, y|
          frontend.puts(window, 0, y + 1, log.message_log!.text)
        end
        frontend.highlight(window, 0, 0)
        frontend.refresh(window)
      end

      def clear
        (0..height).each do |y|
          frontend.puts(window, 0, y, " " * width)
        end
        frontend.box(window)
      end

      def window
        (@_window ||= _window).not_nil!
      end

      def _window
        window = nil
        entity.frontend_window.bind do |w|
          window = w.value
        end

        unless window
          window = frontend.new_window(left, top, width, height)
          entity.frontend_window = Components::FrontendWindow.new(window.not_nil!)
        end

        window
      end

      def left
        MessagesBarConstants::LEFT
      end

      def top
        MessagesBarConstants::TOP
      end

      def width
        MessagesBarConstants::WIDTH
      end

      def height
        size + 3
      end
    end
  end
end
