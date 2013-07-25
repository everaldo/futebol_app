module FutebolApp
  
  class NullPlayer
    def name
      "undefined"
    end

    def number
      "undefined"
    end
  end


  class Player
    def initialize(options = {})
      @name = options.fetch :name, "undefined"
      @number = options.fetch :number, "undefined"
      @team = options.fetch :team, NullTeam
    end
  end
end
