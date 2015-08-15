module Ton
  new_system Color do
    def update
      World.each_component.color do |color|
        frontend.init_color(color) unless color.initialized
      end
    end
  end
end
