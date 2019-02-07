class SwapiController < ApplicationController

  def index
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'

    respond_to do |format|
      format.json do
        things = params[:things].strip.downcase
        dataset_name = "swapi-#{things}"
        data = DataSet.get(dataset_name)
        if data.blank?
          url = "https://swapi.co/api/#{things}"
          uri = URI(url)
          response = Net::HTTP.get(uri)
          data = JSON.parse(response)['results']
          data.each do |thing|
            id = thing['url'].split('/api/')
          DataSet.create(data: response, url: url, name: dataset_name, ttl: 0)
          data =
        end


        render json: data
      end
    end
  end


end
