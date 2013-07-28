module FutebolApp
  class Member

        
    extend Forwardable
    attr_reader :team, :id
    attr_accessor :points, :games_played, :wins, :losses, :draws,
                  :goals_scored, :goals_against, :results

    def_delegators :team, :name
    def_delegators :@stats, :points, :games_played, :wins, :losses, :draws, :goals_scored, :goals_against, :results, :goal_difference

    def initialize(options = {})
      @team         = options.fetch :team
      @id           = options.fetch :id, SecureRandom.uuid
      @position     = options.fetch :position, 1
      @league       = options.fetch :league, NullLeague
      @results      = Hash.new
      reset!
    end

    def reset!
      @stats = MemberStatistics.new(self)
     end

    def win!(result)
      @stats.win!(result)
    end

    def loss!(result)
      @stats.loss!(result)
    end

    def draw!(result)
      @stats.draw!(result)
    end
    
    def <=>(other)
      @stats <=> other
    end

    def to_s
      name
    end
  end
end
