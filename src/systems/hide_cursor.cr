module Ton
  new_system HideCursor do
    def draw
      frontend.reset_pos
    end
  end
end
