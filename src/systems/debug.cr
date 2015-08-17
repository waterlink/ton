module Ton
  new_system Debug do
    def keypress(key)
      Logger.debug key
      false
    end
  end
end
