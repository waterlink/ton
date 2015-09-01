module Ton
  abstract class Component
    getter entity
    def entity=(entity)
      @entity = entity
      if entity
        __register
      else
        __deregister
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

        def __register
          __world.registry.fetch_{{name.id}}.register(self)
        end

        def __deregister
          __world.registry.fetch_{{name.id}}.deregister(self)
        end

        def __world
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
