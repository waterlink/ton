module Ton
  class Entity
    macro method_missing(name, args, block)
      {% if name.ends_with?("!") %}

        {% original_name = name.gsub(%r{!$}, "") %}
        @_{{original_name.id}}.not_nil!.unwrap!

      {% elsif name.ends_with?("=") %}

        {% original_name = name.gsub(%r{=$}, "") %}
        {{args[0]}}.entity = self
        @_{{original_name.id}} = Components::{{original_name.camelcase.id}}::Just.new({{args.argify}})

      {% else %}

        (@_{{name.id}} ||= Components::{{name.camelcase.id}}::None.new).not_nil!

      {% end %}
    end
  end
end
