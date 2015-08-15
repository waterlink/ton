require "./ton"
require "./frontend/curses"
require "./story"

module Ton
  FPS = 30
  FRONTEND = Frontend::Driver.new

  app = Application.new(FRONTEND, FPS, [
    Systems::Color,
    Systems::Display,
    Systems::Menu,

    Systems::Movement,

    Systems::Camera,
    Systems::CharacterSelect,
    Systems::FrontendRefresh,

    Systems::TurnFlow,
  ])

  begin
    app.start
  ensure
    FRONTEND.close
  end
end
