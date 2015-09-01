module Ton
  new_system StatusBar do
    def draw
      w = window
      frontend.puts(w, 0, 0, " " * StatusBarConstants::WIDTH)
      frontend.puts(w, 0, 1, " " * StatusBarConstants::WIDTH)
      frontend.box(w)
      frontend.puts(w, 0, 0, status.text)
      frontend.refresh(w)
    end

    def window
      window = nil

      status_bar.frontend_window.bind do |w|
        window = w.value
      end

      unless window
        window = frontend.new_window(
          StatusBarConstants::LEFT,
          StatusBarConstants::TOP,
          StatusBarConstants::WIDTH,
          StatusBarConstants::HEIGHT,
        )

        status_bar.frontend_window = Components::FrontendWindow.new(window.not_nil!)
      end

      window.not_nil!
    end

    def status
      world.each_component.status_bar_text.first
    end

    def status_bar
      world.each.status_bar.first
    end
  end
end
