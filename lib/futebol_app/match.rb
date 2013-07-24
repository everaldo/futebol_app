require "securerandom"

module FutebolApp
  class NullTeam
    def add_match
    end
  end

  class Match
    attr_accessor :home, :visitor, :id

    def initialize(options = {})
      @id = options.fetch :id, SecureRandom.uuid
      @home = options.fetch :home, NullTeam
      @visitor = options.fetch :visitor, NullTeam
      home.add_match self
      visitor.add_match self
    end

    def to_s
      "#{home} vs #{visitor}"
    end

  end
end
