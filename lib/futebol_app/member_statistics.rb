class MemberStatistics
      attr_reader :member
        attr_accessor :points, :games_played, :wins, :losses,
              :draws, :goals_scored, :goals_against, :results

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
      
      def goal_difference
        goals_scored - goals_against
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

      def name
        member.name
      end

      def <=>(other)
        return  -1 if points > other.points
        return   1 if other.points > points
        return  -1 if wins > other.wins
        return   1 if other.wins > wins
        return  -1 if goal_difference > other.goal_difference
        return   1 if other.goal_difference >  goal_difference
        return  -1 if goals_scored > other.goals_scored
        return   1 if other.goals_scored > goals_scored
        return  -1 if name < other.name
        return   1
      end

    end
    

