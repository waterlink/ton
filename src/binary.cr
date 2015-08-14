require "./ton"
require "./frontend/curses"
require "./story"

module Ton
  FPS = 30
  FRONTEND = Frontend::Driver.new

  app = Application.new(FRONTEND, FPS, [
    Systems::Display,

    Systems::Camera,
    Systems::CharacterSelect,
  ])

  app.start
end
