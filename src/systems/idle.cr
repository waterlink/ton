module Ton
  new_system Idle do
    def update
      world.each.character do |character|
        Activity.new(character).handle_idle
      end
    end

    class Activity
      getter character
      def initialize(@character)
      end

      def handle_idle
        set_idle
        unset_idle
      end

      def set_idle
        return unless idle?
        character.idle = Components::Idle.new(true)
      end

      def unset_idle
        return if idle?
        character.idle.bind do |x|
          character.idle = nil
        end
      end

      def idle?
        [
          selected?,
          moves?,
          dead?,
        ].none?
      end

      def selected?
        character.selected_character?
      end

      def moves?
        character.movement_target?
      end

      def dead?
        character.dead?
      end
    end
  end
end
