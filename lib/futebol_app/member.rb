require "securerandom"

module FutebolApp
  class Member
    attr_reader :team, :id

    def initialize(options = {})
      @team = options.fetch :team
      @id = options.fetch :id, SecureRandom.uuid
    end
  end
end
