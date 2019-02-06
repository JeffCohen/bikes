class StationsController < ApplicationController

  def index
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    
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
