module Ton
  class Application
    getter frontend, fps, prev_frame, frame_size, systems, system_factories
    def initialize(@frontend, @fps, @system_factories)
      @prev_frame = now
      @frame_size = 1.0 / fps
      @systems = system_factories.map &.build(frontend)
    end

    def start
      loop do
        frame
      end
    end

    def frame
      keypress(frontend.get_key)
      update
      draw
      wait_for_frame
    rescue e
      p e
    end

    def update
      systems.each &.update
    end

    def draw
      systems.each &.draw
    end

    def keypress(key)
      return unless key
      systems.each &.keypress(key.not_nil!)
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
  end
end
