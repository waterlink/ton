module Ton
  new_system GlobalCancel do
    def keypress(key)
      return unless key == ControlConstants::ESC
      e = Entity.new
      e.cancel_menu = Components::CancelMenu.new(true)
      e.unselect_character = Components::UnselectCharacter.new(true)
    end
  end
end
