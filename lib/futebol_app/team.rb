module FutebolApp
  class NullTeam
    def add_match
    end
  end

  class Team
    attr_reader :players
    attr_accessor :name, :matches


    def initialize(options = {})
      @name = options.fetch :name, "undefined"
      @players = options.fetch :players, [] 
      @matches = options.fetch :matches, []
    end

    def add_match(match)
      matches << match
    end

    def to_s
      name
    end
  end
end
