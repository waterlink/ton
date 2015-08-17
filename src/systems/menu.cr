module Ton
  new_system Menu do
    CONTROLS = {
      ControlConstants::UP => (-> (m : Entity) { activate_item(m, -1); true }),
      ControlConstants::DOWN => (-> (m : Entity) { activate_item(m, +1); true }),
      ControlConstants::ENTER => (-> (m : Entity) { trigger(m); true }),
    }

    NULL_CONTROL = -> (m : Entity) { false }

    def draw
      World.each.active_menu do |menu|
        DrawMenu.new(frontend, menu).call
      end
    end

    def update
      World.each.cancel_menu do |cancel|
        World.each.active_menu do |menu|
          menu.active_menu = nil
          menu.active_window = nil
          menu.frontend_window.bind do |window|
            frontend.close(window.value)
          end
          menu.frontend_window = nil
        end

        World.each.static_camera do |camera|
          camera.static_camera = nil
        end

        cancel.cancel_menu = nil
      end
    end

    def keypress(key)
      did_something = false
      World.each.active_menu do |menu|
        did_something ||= CONTROLS.fetch(key, NULL_CONTROL).call(menu)
        did_something ||= shortcuts(menu).fetch(key, NULL_CONTROL).call(menu)
      end
      did_something
    end

    def shortcuts(menu)
      shortcuts = {} of Array(Int32) => (Entity) ->
      menu.menu!.items.each_with_index do |item, i|
        shortcut = [item.text[0].downcase.ord]
        unless shortcuts.has_key?(shortcut)
          shortcuts[shortcut] = -> (m : Entity) { self.class.trigger(m, i) }
        end
      end
      shortcuts
    end

    def self.activate_item(menu, di)
      return if len(menu) == 0
      old_active = active_item(menu)
      new_active = (old_active + di) % len(menu)
      menu.menu!.items[old_active].active = false
      menu.menu!.items[new_active].active = true
    end

    def self.active_item(menu)
      active = -1
      menu.menu!.items.each_with_index do |item, i|
        active = i if item.active
      end
      active
    end

    def self.len(menu)
      menu.menu!.items.count
    end

    def self.trigger(menu)
      item = menu.menu!.items[active_item(menu)]
      action = item.action
      if action
        e = Entity.new
        action.each do |component|
          component.call(e)
        end
      end
    end

    def self.trigger(menu, i)
      menu.menu!.items[active_item(menu)].active = false
      menu.menu!.items[i].active = true
      trigger(menu)
    end

    class DrawMenu
      getter frontend, menu
      def initialize(@frontend, @menu)
      end

      def call
        mark_camera_as_static
        frontend.box(window)
        active = -1
        menu.menu!.items.each_with_index do |item, i|
          frontend.set_color(window, frontend.black_on_white) if item.active
          frontend.puts(window, 0, i, item.text)
          frontend.reset_color(window)
          active = i if item.active
        end
        frontend.highlight(window, 0, active)
      end

      def window
        (@_window ||= _window).not_nil!
      end

      def _window
        window = nil
        menu.frontend_window.bind do |w|
          window = w.value
        end

        unless window
          window = frontend.new_window(
            DisplayConstants::WIDTH / 4,
            DisplayConstants::HEIGHT / 4,
            DisplayConstants::WIDTH / 2,
            DisplayConstants::HEIGHT / 2,
          )

          menu.frontend_window = Components::FrontendWindow.new(window.not_nil!)
          menu.active_window = Components::ActiveWindow.new(true)
        end

        window
      end

      def mark_camera_as_static
        World.each.camera do |camera|
          already_static = false
          camera.static_camera.bind do |x|
            already_static = true
          end

          unless already_static
            camera.static_camera = Components::StaticCamera.new(true)
          end
        end
      end
    end
  end
end
