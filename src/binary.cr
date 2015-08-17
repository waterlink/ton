require "./ton"
require "./frontend/curses"
require "./story"

module Ton
  FPS = 30
  FRONTEND = Frontend::Driver.new

  app = Application.new(FRONTEND, FPS, [
    Systems::Debug,

    Systems::Color,
    Systems::Display,
    Systems::Menu,
    Systems::StatusBar,
    Systems::CharacterStatus,
    Systems::TargetStatus,

    Systems::Movement,
    Systems::Attack,
    Systems::Idle,

    Systems::Damage,
    Systems::Death,
    Systems::Energy,

    Systems::AutoTarget,
    Systems::MeleeAi,

    Systems::Camera,
    Systems::CharacterSelect,
    Systems::FrontendRefresh,

    Systems::GlobalCancel,
    Systems::TurnFlow,
  ])

  begin
    app.start
  ensure
    FRONTEND.close
  end
end
