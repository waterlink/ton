require "./ton"
require "./frontend/curses"
require "./story"

module Ton
  FPS = 30
  FRONTEND = Frontend::Driver.new

  app = Application.new(FRONTEND, FPS, [
    Systems::Display,
    Systems::Menu,

    Systems::Camera,
    Systems::CharacterSelect,
    Systems::FrontendRefresh,
  ])

  begin
    app.start
  ensure
    FRONTEND.close
  end
end
