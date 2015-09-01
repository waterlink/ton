module Ton
  module WorldTypes
    BattleWorld = [
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

      Systems::HideCursor,
    ]
  end
end
