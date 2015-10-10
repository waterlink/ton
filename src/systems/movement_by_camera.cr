module Ton
  new_system MovementByCamera do
    def update
      return unless camera?
      return unless party?
      return if same_position?

      return restore_camera unless nothing_under_camera?

      party.position!.x = camera.position!.x
      party.position!.y = camera.position!.y
    end

    def restore_camera
      camera.position!.x = party.position!.x
      camera.position!.y = party.position!.y
    end

    def nothing_under_camera?
      world.each.blocks_movement do |entity|
        next unless entity.position?
        next unless Position.same_position?(camera.position!, entity.position!)
        return false
      end

      true
    end

    def same_position?
      Position.same_position?(party.position!, camera.position!)
    end

    def camera?
      world.each.camera.any? && camera.position?
    end

    def party?
      world.each.character.any? && party.position?
    end

    def camera
      world.each.camera.first
    end

    def party
      world.each.character.first
    end
  end
end
