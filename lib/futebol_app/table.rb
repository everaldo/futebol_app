module FutebolApp
  class Table
    def initialize(options = {})
      @members = options.fetch :members, []
    end
  end
end
