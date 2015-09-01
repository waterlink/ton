module Ton
  new_system Quit do
    def update
      return unless world.each.quit.any?
      exit(0)
    end
  end
end
