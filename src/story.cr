module Ton
  player = Entity.new
  player.player = Components::Player.new(true)
  player.tile = Components::Tile.new("@")
  player.position = Components::Position.new(15, 15)

  camera = Entity.new
  camera.camera = Components::Camera.new(true)
  camera.position = Components::Position.new(5, 7)
end
