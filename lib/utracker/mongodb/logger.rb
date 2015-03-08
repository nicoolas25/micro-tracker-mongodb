module Utracker
  module MongoDB
    class Logger < Utracker::Logger
      def initialize(url=nil)
        fail 'An MongoDB URL should be passed to this Logger'
      end

      def write(event)
        # TODO
      end
    end
  end
end
