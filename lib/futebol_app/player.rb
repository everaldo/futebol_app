module FutebolApp
  
  class NullPlayer
    def name
      "undefined"
    end

    def number
      "undefined"
    end

    def team
      "undefined"
    end
  end


  class Player
    attr_reader :name, :number, :team


    def initialize(options = {})
      @name = options.fetch :name, "undefined"
      @number = options.fetch :number, "undefined"
      @team = options.fetch :team, NullTeam
    end
  end
end
