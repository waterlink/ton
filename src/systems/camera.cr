module Ton
  new_system Camera do
    def draw
      World.each.camera do |camera|
        frontend.highlight(camera.position!.x, camera.position!.y)
      end
    end
  end
end
