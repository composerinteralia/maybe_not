require 'singleton'

module Maybe
  class Nothing
    include Singleton

    class NothingToSeeHere < StandardError
      def message
        "called 'get' on Nothing"
      end
    end

    def else(&blk)
      blk.()
    end

    def get
      raise NothingToSeeHere
    end

    def nothing?
      true
    end

    def something?
      false
    end

    def method_missing(*)
      self
    end
  end
end
