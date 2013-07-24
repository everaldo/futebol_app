module FutebolApp

  class NullMatch
  end

  class Result
    def initialize(options = {})
      @match = options.fetch :match, NullMatch
    end
  end
end
