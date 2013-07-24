module FutebolApp
  class League
    attr_reader :members
    attr_accessor :matches

    def initialize(options = {})
      @teams = options.fetch :teams, []
      generate_members
      generate_matches
    end


    private
    def generate_members
      @members = []
      @teams.each.with_index(1) do |team, index|
        @members << Member.new(team: team, id: index)
      end
    end


    def generate_matches
      @matches = [] 
      @members.permutation(2).with_index(1) do |match, index|
        matches << Match.new(home: match[0], visitor: match[1], id: index )
      end
    end
  end
end
