module Ton
  class WorldClass
    def each
      Each
    end

    def each_component
      EachComponent
    end
  end

  class EachClass
    macro method_missing(name, args, block)
      {% component_name = name.camelcase.id %}
      Components::{{component_name}}
      Components::{{component_name}}Registry
        .items
        .map(&.entity.not_nil!)
        .each {{block}}
    end
  end

  class EachComponentClass
    macro method_missing(name, args, block)
      {% component_name = name.camelcase.id %}
      Components::{{component_name}}
      Components::{{component_name}}Registry
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
  end

  World = WorldClass.new
  Each = EachClass.new
  EachComponent = EachComponentClass.new
end
