module FutebolApp
  class Team
    attr_reader :players
    attr_accessor :name


    def initialize(options = {})
      @name = options.fetch :name, "undefined"
      @players = options.fetch :players, [] 

    end
  end
end
