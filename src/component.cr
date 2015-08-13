module Ton
  abstract class Component
    getter entity
    def entity=(entity)
      @entity = entity
      register
    end

    abstract def register
  end

  macro new_component(name, *props)
    module Components
      class {{name.id}} < Component
        property {{props.argify}}
        def initialize({{props.map { |x| "@#{x}".id }.argify}})
        end

        def register
          {{name.id}}Registry.register(self)
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

      {{name.id}}Registry = Registry({{name.id}}).new
    end
  end
end
