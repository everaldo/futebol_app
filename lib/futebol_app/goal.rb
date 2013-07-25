module FutebolApp
  class Goal
    attr_reader :team

    def initialize(options = {})
      @team     = options.fetch :team
      @player   = options.fetch :player, NullPlayer
      @minutes  = options.fetch :minutes, "undefined"
    end
  end
end
