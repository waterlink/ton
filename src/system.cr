module Ton
  abstract class SystemFactory
    abstract def build(frontend) : System
  end

  abstract class System
    def update
    end

    def draw
    end

    getter frontend
    def initialize(@frontend)
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
