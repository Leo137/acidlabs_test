class ForecastBroadcastWorker
  include Sidekiq::Worker

  def perform(*args)
    # Get ForecastsController
    Rails.cache.fetch('cities') and sleep(5)
    forecasts = CityForecastRetriever.new.get_forecasts
    # Broadcast
    ActionCable.server.broadcast "forecast", { 
      message: ForecastsController.render(
        partial: 'forecasts', 
        locals: { forecasts: forecasts }
      ).squish 
    }
  end
end
