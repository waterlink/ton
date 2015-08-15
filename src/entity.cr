module Ton
  class Entity
    macro method_missing(name, args, block)
      {% if name.ends_with?("!") %}

        {% original_name = name.gsub(%r{!$}, "") %}
        @_{{original_name.id}}.not_nil!.unwrap!

      {% elsif name.ends_with?("=") %}

        {% original_name = name.gsub(%r{=$}, "") %}
        if {{args[0]}}
          if @_{{original_name.id}}
            @_{{original_name.id}}.not_nil!.bind { |c| c.entity = nil }
          end

          {{args[0]}}.entity = self
          @_{{original_name.id}} = Components::{{original_name.camelcase.id}}::Just.new({{args.argify}})
        else
          @_{{original_name.id}}.not_nil!.unwrap!.entity = nil
          @_{{original_name.id}} = Components::{{original_name.camelcase.id}}::None.new
        end

      {% else %}

        (@_{{name.id}} ||= Components::{{name.camelcase.id}}::None.new).not_nil!

      {% end %}
    end
  end
end
