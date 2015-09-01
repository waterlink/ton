module Ton
  abstract class Component
    getter entity
    def entity=(entity)
      @entity = entity
      if entity
        register
      else
        deregister
      end
    end

    abstract def register
    abstract def deregister
  end

  macro new_component(name, *props)
    module Components
      class {{name.id}} < Component
        property {{props.argify}}
        def initialize({{props.map { |x| "@#{x}".id }.argify}})
        end

        def register
          world.registry.fetch_{{name.id}}.register(self)
        end

        def deregister
          world.registry.fetch_{{name.id}}.deregister(self)
        end

        def world
          (@_world ||= Universe.world).not_nil!
        end

        class Just
          getter value
          def initialize(@value : {{name.id}})
          end

          def bind(&block : ({{name.id}}) ->)
            block.call(value)
          end

          def unwrap!
            value
          end
        end

        class None
          def bind(&block : ({{name.id}}) ->)
          end

          def unwrap!
            raise "Unable to unwrap {{name.id}}::None"
          end
        end
      end
    end
  end
end
