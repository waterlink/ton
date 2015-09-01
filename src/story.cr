require "./story/world_types"
require "./story/worlds"
require "./story/*"
require "./story/test/*"

module Ton
  Universe.default_world = MAIN_MENU_WORLD
end
