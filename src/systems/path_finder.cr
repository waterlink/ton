module Ton
  new_system PathFinder do
    def update
      clear_paths
      find_paths
      clear_empty_paths
    end

    def clear_paths
      world.each.movement_path do |entity|
        next if entity.movement_target?
        entity.movement_path = nil
      end
    end

    def clear_empty_paths
      world.each.movement_path do |entity|
        next if entity.movement_path!.waypoints.size > 0
        entity.movement_path = nil
        entity.movement_target = nil
      end
    end

    def find_paths
      map = Map.new(world)

      world.each.movement_target do |entity|
        next if entity.movement_path?
        next unless entity.position?

        entity.movement_path = Components::MovementPath.new([] of Components::Position)
        ResolvePath
          .new(map, entity.movement_path!.waypoints, entity.position!, entity.movement_target!)
          .call
      end
    end

    class ResolvePath
      DCELL = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]

      getter cells, queue, queue_head, map, waypoints, start, target
      def initialize(@map, @waypoints, @start, @target)
        @cells = {start_cell => 0}
        @queue = [start_cell]
        @queue_head = 0
      end

      def call
        restore_waypoints if wave_algorithm
      end

      def wave_algorithm
        while !empty_queue? && !target_reached?
          cell = next_cell
          each_cell_from(cell) do |new_cell|
            unless cells[new_cell]? || map[new_cell]
              cells[new_cell] = cells[cell] + 1
              queue << new_cell
            end
          end
        end

        target_reached?
      end

      def restore_waypoints
        cell = target_cell

        while cell != start_cell
          waypoints << Components::Position.new(cell[0], cell[1])
          next_cell = cell

          each_cell_from(cell) do |new_cell|
            if cells[new_cell]? == cells[cell] - 1
              next_cell = new_cell
              :break
            end
          end

          cell = next_cell
        end

        waypoints.reverse!
      end

      def next_cell
        @queue_head += 1
        queue[queue_head - 1]
      end

      def start_cell
        {start.x, start.y}
      end

      def target_cell
        {target.x, target.y}
      end

      def each_cell_from(cell)
        DCELL
          .map { |dcell| {cell[0] + dcell[0], cell[1] + dcell[1]} }
          .each do |cell|
          action = yield(cell)
          break if action == :break
        end
      end

      def empty_queue?
        queue_head >= queue.size
      end

      def target_reached?
        return false unless cells[target_cell]?
        cells[target_cell] > 0
      end
    end

    class Map
      getter world, cells
      def initialize(@world)
        @cells = {} of {Int32, Int32} => Bool
        populate_cells
      end

      def populate_cells
        world.each.blocks_movement do |entity|
          entity.position.bind do |position|
            cells[{position.x, position.y}] = true
          end
        end
      end

      def [](key)
        cells[key]?
      end
    end
  end
end
