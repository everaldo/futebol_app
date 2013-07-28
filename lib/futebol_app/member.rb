module FutebolApp
  class Member

    class Statistics
      attr_reader :member
        attr_accessor :points, :games_played, :wins, :losses, :draws, :goals_scored, :goals_against, :results

      def initialize(member)
        @member         = member
        @points         = 0
        @games_played   = 0
        @wins           = 0
        @losses         = 0
        @draws          = 0
        @goals_scored   = 0
        @goals_against  = 0
        @results        = Hash.new 
      end


      def win!(result)
        return if results.include?(result.id)
        @results[result.id] = result
        @points += 3
        @games_played += 1
        @wins += 1
        @goals_scored += result.goals_for(member)
        @goals_against += result.goals_for_opponent(member)
      end
      def loss!(result)
        return if results.include?(result.id)
        @results[result.id] = result
        @games_played +=1
        @losses +=1
        @goals_scored += result.goals_for(member)
        @goals_against += result.goals_for_opponent(member)
      end

      def draw!(result)
        return if results.include?(result.id)
        @results[result.id] = result
        @points += 1
        @games_played +=1
        @draws +=1
        @goals_scored += result.goals_for(member)
        @goals_against += result.goals_for_opponent(member)
      end
    end
    
    
    extend Forwardable
    attr_reader :team, :id
    attr_accessor :points, :games_played, :wins, :losses, :draws,
                  :goals_scored, :goals_against, :results

    def_delegators :team, :name
    def_delegators :@stats, :points, :games_played, :wins, :losses, :draws, :goals_scored, :goals_against, :results

    def initialize(options = {})
      @team         = options.fetch :team
      @id           = options.fetch :id, SecureRandom.uuid
      @position     = options.fetch :position, 1
      @league       = options.fetch :league, NullLeague
      @results      = Hash.new
      reset!
    end

    def reset!
      @stats = Statistics.new(self)
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

    def goal_difference
      goals_scored - goals_against
    end

    def to_s
      name
    end
  end
end
