class ForecastBroadcastWorker
  include Sidekiq::Worker

  def perform(*args)
    # Get ForecastsController
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
