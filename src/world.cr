module Ton
  class UniverseClass
    getter world
    def initialize(@world = create_default_world)
    end

    def switch_to(world)
      @world = world
    end

    def self.create_default_world
      World.new
    end
  end

  class World
    getter systems, registry
    def initialize(@systems = [] of System)
      @registry = RegistryRegistry.new
    end

    def each
      Each.new(self)
    end

    def each_component
      EachComponent.new(self)
    end
  end

  class Each
    getter world
    def initialize(@world)
    end

    macro method_missing(name, args, block)
      {% component_name = name.camelcase.id %}
      # just for type-safety here
      Components::{{component_name}}

      world
        .registry
        .fetch_{{component_name}}
        .items
        .map(&.entity.not_nil!)
        .each {{block}}
    end
  end

  class EachComponent
    getter world
    def initialize(@world)
    end

    macro method_missing(name, args, block)
      {% component_name = name.camelcase.id %}
      # just for type-safety here
      Components::{{component_name}}

      world
        .registry
        .fetch_{{component_name}}
        .items
        .each {{block}}
    end
  end

  class Registry(T)
    getter items
    def initialize
      @items = [] of T
    end

    def register(item)
      items << item
    end

    def deregister(item)
      items.delete(item)
    end
  end

  class RegistryRegistry
    macro method_missing(name, args, block)
      {% if name.starts_with?("fetch_") %}
        {% component_name = name[6..-1] %}
        (@_{{component_name.id}} ||= self._{{component_name.id}}).not_nil!
      {% elsif name.starts_with?("_") %}
        {% component_name = name[1..-1] %}
        Registry(Components::{{component_name.id}}).new
      {% end %}
    end
  end

  Universe = UniverseClass.new
end
