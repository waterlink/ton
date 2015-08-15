module Ton
  class LoggerClass
    FILE = File.open("log.txt", "w")

    def log(*args)
      FILE.puts(*args)
      FILE.flush
    end

    macro method_missing(name, args, block)
      log("[{{name.capitalize.id}}]", {{args.argify}})
    end
  end

  Logger = LoggerClass.new
end
