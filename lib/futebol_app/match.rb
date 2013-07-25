module FutebolApp
  class NullMatch
    def home
      "undefined"
    end

    def visitors
      "undefined"
    end
  end

  class Match
    attr_accessor :home, :visitors, :id, :result
    attr_reader :league

    def initialize(options = {})
      @id       = options.fetch :id, SecureRandom.uuid
      @home     = options.fetch :home, NullTeam
      @visitors  = options.fetch :visitors, NullTeam
      @league   = options.fetch :league, NullLeague
      home.add_match self
      visitors.add_match self
    end

    def to_s
      "#{home} vs #{visitors}"
    end

  end
end
