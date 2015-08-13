module Ton
  player = Entity.new
  player.tile = Components::Tile.new("@")
  player.position = Components::Position.new(5, 7)

  camera = Entity.new
  camera.camera = Components::Camera.new(true)
  camera.position = Components::Position.new(5, 7)
end
