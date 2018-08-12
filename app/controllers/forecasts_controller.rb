class ForecastsController < ApplicationController
  before_action :get_forecasts

  def index
  end

  private

  def get_forecasts
    @forecasts = CityForecastRetriever.new.get_forecasts
  end
end
