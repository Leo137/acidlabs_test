module DarkSky
  module Error
    class BaseError < StandardError
      attr_accessor :code
      def initialize(msg, code)
        self.code = code
        super msg
      end
    end
  end
end