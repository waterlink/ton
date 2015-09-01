module Ton
  abstract class SystemFactory
    abstract def build(frontend) : System
  end

  abstract class System
    def update
    end

    def draw
    end

    def keypress(key)
    end

    getter frontend, world
    def initialize(@frontend, @world = get_current_world)
    end

    def self.get_current_world
      Universe.world
    end
  end

  macro new_system(name, &block)
    module Systems
      class {{name.id}}Factory < SystemFactory
        def build(frontend) : System
          Instance.new(frontend)
        end

        class Instance < System
          {{block.body}}
        end
      end

      {{name.id}} = {{name.id}}Factory.new
    end
  end
end
