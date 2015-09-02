module Ton
  new_system MovementByCamera do
    def update
      return unless camera?
      return unless party?

      party.position.bind do |position|
        position.x = camera.position!.x
        position.y = camera.position!.y
      end
    end

    def camera?
      world.each.camera.any?
    end

    def party?
      world.each.character.any?
    end

    def camera
      world.each.camera.first
    end

    def party
      world.each.character.first
    end
  end
end
