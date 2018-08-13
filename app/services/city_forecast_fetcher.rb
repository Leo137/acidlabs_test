class CityForecastFetcher
  attr_accessor :cities, :api, :redis

  def initialize
    self.cities = Rails.cache.fetch('cities')
    self.redis = Redis.new
    self.api = DarkSky::Api.new
  end

  def process
    return unless cities && redis && api

    cities.each do |city|
      process_city(city)
    end

    broadcast
  end

  private

  def broadcast
    ForecastBroadcastWorker.perform_in(1.minute)
  end

  def process_city(city)
    return unless result = get_city_result(city)

    save_city_result(city, result)
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
    Rails.cache.write(key + '/timezone', result['timezone']) if result['timezone']
    Rails.cache.write(key + '/time', result['currently']['time']) if result['currently']['time']
    Rails.cache.write(key + '/temperature', result['currently']['temperature']) if result['currently']['temperature']
  end

  def city_base_key(city)
    "cities/#{city[:lattitude]}/#{city[:longitude]}"
  end
end
