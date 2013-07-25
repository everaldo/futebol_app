module FutebolApp
  class Table
    extend Forwardable

    attr_reader :league, :results

    def_delegators :league, :members

    def initialize(options = {})
      @league = options.fetch :league, NullLeague
      
    end

    def add_result(result)
      results << result
    end

    def compute!
      reset_members!
      results.each do |result|
        result.compute!
      end
    end


    private
    def reset_members!
      members.each(:reset!)
    end


  end
end
