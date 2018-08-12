module DarkSky
  module Error
    class BaseError < StandardError
      include ActiveModel::Serialization

      attr_accessor :code
      def initialize(msg, code)
        self.code = code
        super msg
      end

      def attributes
        {
          message: message,
          code: code
        }
      end
    end
  end
end