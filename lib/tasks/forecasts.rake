namespace :forecasts do
  desc "Fetch forecasts from DarkSky api, saves them into redis and broadcasts it using ForecastChannel"
  task :fetch => :environment do
    puts 'fetching forecasts...'
    CityForecastFetcher.new.process
    puts 'finished fetching forecasts'
  end
end