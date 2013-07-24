require "securerandom"

module FutebolApp
  class NullTeam
  end

  class Match
    attr_accessor :home, :visitor, :id

    def initialize(options = {})
      @id = options.fetch :id, SecureRandom.uuid
      @home = options.fetch :home, NullTeam
      @visitor = options.fetch :visitor, NullTeam
    end
  end
end
