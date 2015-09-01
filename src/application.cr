module Ton
  class Application
    getter frontend, fps, prev_frame, frame_size
    def initialize(@frontend, @fps)
      @prev_frame = now
      @frame_size = 1.0 / fps
    end

    def start
      loop do
        frame
      end
    end

    def frame
      set_current_world
      keypress(frontend.get_key_sequence)
      update
      draw
      wait_for_frame
    rescue e
      Logger.error e.inspect
    end

    def update
      systems.each &.__update(same_world?)
    end

    def draw
      systems.each &.__draw(same_world?)
    end

    def keypress(key)
      return unless key.count > 0
      systems.find &.__keypress(same_world?, key.not_nil!)
    end

    def wait_for_frame
      to_wait = (prev_frame + frame_size.seconds - now).to_f
      if to_wait > 0
        sleep(to_wait)
      end
      @prev_frame = now
    end

    def now
      Time.now
    end

    def systems
      Universe.world.init_if_required(frontend)
      Universe.world.systems
    end

    def set_current_world
      @current_world = Universe.world
    end

    def same_world?
      @current_world == Universe.world
    end
  end
end
