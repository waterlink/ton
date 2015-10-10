module Ton
  new_system Terrain do
    def update
      return unless world.each.terrain.any?

      tiles = {} of Char => Components::TerrainTile
      world.each_component.terrain_tile do |tile|
        tiles[tile.tile] = tile
      end

      sub_tiles = {} of Char => Components::TerrainSubTile
      world.each_component.terrain_sub_tile do |sub_tile|
        sub_tiles[sub_tile.tile] = sub_tile
      end

      world.each.terrain do |entity|
        terrain = entity.terrain!

        terrain.lines.each_with_index do |line, y|
          line.split("").each_with_index do |tile_char, x|
            char = tile_char[0]
            next unless tiles[char]?
            create_tile(terrain, x, y, tiles[char], sub_tiles)
          end
        end

        entity.terrain = nil
      end
    end

    def create_tile(terrain, x, y, tile, sub_tiles)
      sx = terrain.x + x * terrain.tw
      sy = terrain.y + y * terrain.th

      tile.lines.each_with_index do |line, y|
        line.split("").each_with_index do |tile_char, x|
          char = tile_char[0]
          next unless sub_tiles[char]?
          create_sub_tile(sx + x, sy + y, sub_tiles[char])
        end
      end
    end

    def create_sub_tile(x, y, sub_tile)
      e = Entity.new
      e.position = Components::Position.new(x, y)
      sub_tile.value.call(e)
      Logger.info "created tile (#{x}; #{y})"
    end
  end
end
