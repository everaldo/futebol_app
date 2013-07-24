require "securerandom"

module FutebolApp
  class Member
    extend Forwardable
    attr_reader :team, :id

    def_delegators :team, :name

    def initialize(options = {})
      @team = options.fetch :team
      @id = options.fetch :id, SecureRandom.uuid
      @position = options.fetch :position, 1
      @points = 0
      @games_played = 0
      @wins = 0
      @draws = 0
      @losses = 0
      @goals_scored = 0
      @goals_against = 0
      @goal_difference = 0
    end

    def to_s
      name
    end
  end
end
