module DarkSky
  class Api
    attr_accessor :secret_key, :result_code, :result

    def initialize(secret_key = nil)
      self.secret_key = secret_key || Rails.application.credentials.dark_sky_secret_key
    end

    def forecast(latitude, longitude)
      do_request "forecast/#{secret_key}/#{latitude},#{longitude}"
    end

    # Helpers

    def is_success?
      result && result_code == 200
    end

    private

    def headers
      h = {
        content_type: :json,
        accept: :json
      }
      h
    end

    def do_request(uri, params={}, verb=:get)
      raise_error if rand(0..100) < 10

      if verb == :get || verb == :delete
        parse_result(RestClient.send(verb, base_url + uri, headers))
      else
        parse_result(RestClient.send(verb, base_url + uri, params.to_json, headers))
      end
    end

    def parse_result(r)
      self.result_code = r.code
      if r
        self.result = JSON.parse(r.body)
      end
    end

    def base_url
      'https://api.darksky.net/'
    end

    def raise_error
      raise DarkSky::Error::BaseError.new('How unfortunate! The API Request Failed', -1)
    end
  end
end