module FutebolApp
  class Result
    extend Forwardable

    attr_reader :goals, :match, :winner, :loser
    attr_accessor :status

    def_delegators :match, :home, :visitors


    def initialize(options )
      @match  = options.fetch :match, NullMatch
      @goals  = options.fetch :goals, []
      @status = options.fetch :status, :scheduled
    end

    def add_goal(goal)
      @goals << goal if pĺaying?
    end

    def for_home
      goals.count { |g| g.team == home }
    end

    def for_visitors
      goals.count { |g| g.team == visitors }
    end

    def goals_for(team)
      goals.count { |g| g.team == team }
    end

    def goals_for_opponent(team)
      return for_visitors if team == home
      return for_home if team ==  visitors
    end


    def draw?
      true if for_home == for_visitors
    end

    def walkover?
      true if status == :walkover
    end

    def pĺaying?
      true if status == :playing
    end

    def kickoff!
      @status = :playing
    end

    def finish!
      @status = :finished
      compute!
    end

    def compute!
      unless draw?
        if for_home > for_visitors
          @winner = home
          @loser  = visitors
        else
          @winner = visitors
          @loser  = home
        end

        winner.win!(self)
        loser.loss!(self)
      else
        if ! walkover?
          home.draw!
          visitors.draw!
        end
      end
    end

    def playing?
      true if status == :playing
    end

    def walkover!(winner = home)
      status = :walkover
      @winner = winner
      @loser = ([home, visitors] - [winner])[0]
    end


    def to_s
      "#{home} - #{for_home} vs #{for_visitors} - #{visitors}"
    end
  end
end
