module Ton
  class UniverseClass
    DEFAULT_WORLD = World.new("default")

    getter world, default_world
    def initialize(@world = DEFAULT_WORLD)
      @default_world = world
    end

    def default_world=(world)
      @default_world = world
      switch_to(world)
    end

    def switch_to(world)
      @world = world
    end

    def create(new_world, &block)
      with_world(new_world, &block)
      new_world.init_components(block)
    end

    def with_world(new_world)
      old_world = world
      switch_to(new_world)
      yield
      switch_to(old_world)
    end

    def reset
      World.worlds.each &.reset
      switch_to(default_world)
    end
  end

  class World
    def self.worlds
      (@@worlds ||= [] of self).not_nil!
    end

    getter name, system_factories, registry, init_components_block
    def initialize(@name, @system_factories = [] of SystemFactory)
      @registry = RegistryRegistry.new
      @init_components_block = -> {}
      self.class.worlds << self
    end

    def to_s(io)
      io << "#<World: #{name}>"
    end

    def each
      Each.new(self)
    end

    def each_component
      EachComponent.new(self)
    end

    def reset
      Logger.debug "#{self}.reset"
      registry.__clear
      Universe.with_world(self) do
        init_components_block.call
      end
    end

    def init_components(@init_components_block)
    end

    def init_if_required(frontend)
      return if @systems
      @systems = system_factories.map &.build(frontend)
    end

    def systems
      @systems.not_nil!
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
      @items = clear
    end

    def register(item)
      items << item
    end

    def deregister(item)
      items.delete(item)
    end

    def clear
      @items = [] of T
    end
  end

  class RegistryRegistry
    # Macro only constant
    REGISTRIES = [] of String

    macro method_missing(name, args, block)
      {% if name.starts_with?("fetch_") %}
        {% component_name = name[6..-1] %}
        (@_{{component_name.id}} ||= self._{{component_name.id}}).not_nil!
      {% elsif name.starts_with?("_") %}
        {% component_name = name[1..-1] %}

        {% unless REGISTRIES.find { |name| name == component_name } %}
          {% REGISTRIES << component_name %}
        {% end %}

        Registry(Components::{{component_name.id}}).new
      {% end %}
    end

    macro def __clear : Nil
      {% for name in REGISTRIES %}
        fetch_{{name.id}}.clear
      {% end %}
      nil
    end
  end

  Universe = UniverseClass.new
end
