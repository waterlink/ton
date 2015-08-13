module Ton
  new_system Camera do
    def draw
      World.each.camera do |camera|
        frontend.highlight(
          DisplayConstants::WIDTH / 2,
          DisplayConstants::HEIGHT / 2,
        )

        return
      end
    end
  end
end
