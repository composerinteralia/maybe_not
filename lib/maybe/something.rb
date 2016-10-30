module Maybe
  class Something
    def initialize(value)
      @value = value
    end

    def get
      value
    end

    alias_method :else, :get

    def if_something(&blk)
      blk.(value)
      self
    end

    def nothing?
      false
    end

    def something?
      true
    end

    def method_missing(method, *args, &blk)
      Maybe(value.send(method, *args, &blk))
    end

    private
    attr_reader :value
  end
end
