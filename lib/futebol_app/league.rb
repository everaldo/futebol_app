module FutebolApp
  class League
    attr_reader :teams
    attr_accessor :matches

    def initialize(options = {})
      @teams = options.fetch :teams, []
      generate_matches
    end


    private
    def generate_matches
      @matches = [] 
      @teams.permutation(2).with_index(1) do |match, index|
        matches << Match.new(home: match[0], visitor: match[1], id: index )
      end
    end
  end
end
