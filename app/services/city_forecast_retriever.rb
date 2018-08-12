class CityForecastRetriever
  attr_accessor :cities

  def initialize
    self.cities = Rails.cache.fetch('cities')
  end

  def get_forecasts
    return [] unless cities

    cities.each.map do |city|
      city.merge(
        time: get_city_key(city, 'time'),
        timezone: get_city_key(city, 'timezone'),
        temperature: get_city_key(city, 'temperature')
      )
    end
  end

  def get_city_key(city, key)
    Rails.cache.fetch(city_base_key(city) + '/' + key)
  end

  def city_base_key(city)
    "cities/#{city[:lattitude]}/#{city[:longitude]}"
  end
end