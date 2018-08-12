class CityForecastFetcher
  attr_accessor :cities, :api, :redis

  def initialize
    self.cities = Rails.cache.fetch('cities')
    self.redis = Redis.new
    self.api = DarkSky::Api.new
  end

  def process
    return unless cities && api

    cities.each do |city|
      process_city(city)
    end
  end

  private

  def process_city(city)
    return unless result = get_city_result(city)
    return unless result['currently']

    save_city_result(city, result['currently'])
  end

  def get_city_result(city)
    api.forecast(city[:lattitude], city[:longitude])
  rescue DarkSky::Error::BaseError => error
    save_api_error(error)
    sleep(1) and retry
  end

  def save_api_error(error)
    redis.hset('api.errors', Time.now.to_i, error.serializable_hash)
  end

  def save_city_result(city, result)
    key = city_base_key(city)
    Rails.cache.write(key + '/time', result['time']) if result['time']
    Rails.cache.write(key + '/temperature', result['temperature']) if result['temperature']
  end

  def city_base_key(city)
    "cities/#{city[:lattitude]}/#{city[:longitude]}"
  end
end
