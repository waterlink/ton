module Ton
  new_system TurnFlow do
    def update
      show_character_selection_menu if selected_character_is_idle?
      show_act_submenu if act_submenu_activated?
    end

    def show_character_selection_menu
      return if character_selection_menu.active_menu?
      return if act_submenu_activated? || act_submenu.active_menu?
      character_selection_menu.active_menu = Components::ActiveMenu.new(true)
    end

    def selected_character_is_idle?
      return false unless selected_character?
      [
        !move_action?,
        !attack_action?,
        !selected_character.movement_target?,
      ].all?
    end

    def show_act_submenu
      return if act_submenu.active_menu?
      return cancel_menu if active_menu?
      act_submenu.active_menu = Components::ActiveMenu.new(true)
      activate_act_submenu.activate_act_submenu = nil
    end

    def cancel_menu
      Entity.new.cancel_menu = Components::CancelMenu.new(true)
    end

    def act_submenu_activated?
      world.each.activate_act_submenu.any?
    end

    def activate_act_submenu
      world.each.activate_act_submenu.first
    end

    def act_submenu
      world.each.act_submenu.first
    end

    def active_menu?
      world.each.active_menu.any?
    end

    def selected_character?
      world.each.selected_character.any?
    end

    def selected_character
      world.each.selected_character.first
    end

    def move_action?
      world.each.move_action.any?
    end

    def attack_action?
      world.each.attack_action.any?
    end

    def character_selection_menu
      world.each.character_selection_menu.first
    end
  end
end
