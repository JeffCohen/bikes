class StationsController < ApplicationController

  def index
    respond_to do |format|
      format.html do
        @stations = DivvyStation.all
      end
      format.json do
        render json: DataSet.get('divvy').to_json
      end
    end
  end

  def show
  end

  def search
    @station = DivvyStation.find_nearest_station(params['address'])
    respond_to do |format|
      format.html
      format.json do
        render json: @station
      end
    end
  end

end
