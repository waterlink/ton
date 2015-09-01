module Ton
  module WorldTypes
    BattleWorld = [
      Systems::Debug,

      Systems::Color,
      Systems::Display,
      Systems::Menu,
      Systems::StatusBar,
      Systems::MessageBar,
      Systems::CharacterStatus,
      Systems::TargetStatus,

      Systems::Movement,
      Systems::Attack,
      Systems::Idle,

      Systems::Damage,
      Systems::Death,
      Systems::Energy,

      Systems::Lose,
      Systems::Win,

      Systems::AutoTarget,
      Systems::MeleeAi,

      Systems::Camera,
      Systems::CharacterSelect,
      Systems::FrontendRefresh,

      Systems::GlobalCancel,
      Systems::TurnFlow,

      Systems::HideCursor,

      Systems::Pause,
      Systems::World,
      Systems::Quit,
    ]

    MenuWorld = [
      Systems::Color,
      Systems::Menu,

      Systems::FrontendRefresh,

      Systems::HideCursor,

      Systems::Pause,
      Systems::UniverseReset,
      Systems::World,
      Systems::Quit,
    ]

    MapOverview = [
      Systems::Debug,

      Systems::Color,
      Systems::Display,
      Systems::Menu,
      Systems::StatusBar,
      Systems::MessageBar,
      Systems::CharacterStatus,
      Systems::TargetStatus,
    ]
  end
end
