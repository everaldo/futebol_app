module FutebolApp

  class NullLeague ;  end

  class League
    attr_reader :members, :table, :id
    attr_accessor :matches

    def initialize(options = {})
      @id = options.fetch :id, SecureRandom.uuid
      @teams = options.fetch :teams, []
      generate_members
      generate_matches
      @table = Table.new(league: self)
    end


    def add_result(result)
      table.add_result result
    end

    private
    def generate_members
      @members = []
      @teams.each.with_index(1) do |team, index|
        @members << Member.new(team: team, id: index, league: self)
      end
    end


    def generate_matches
      @matches = [] 
      @members.permutation(2).with_index(1) do |match, index|
        matches << Match.new(home: match[0], visitors: match[1], id: index, league: self )
      end
    end
  end
end
