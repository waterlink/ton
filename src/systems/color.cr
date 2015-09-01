module Ton
  new_system Color do
    def update
      world.each_component.color do |color|
        frontend.init_color(color) unless color.initialized
      end
    end
  end
end
