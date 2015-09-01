module Ton
  new_system FrontendRefresh do
    def draw
      refreshed = false
      world.each.active_window do |entity|
        entity.frontend_window.bind do |window|
          frontend.refresh(window.value)
          refreshed = true
        end
      end

      unless refreshed
        frontend.refresh
      end
    end
  end
end
