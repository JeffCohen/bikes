class SwapiController < ApplicationController

  def show
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'

    respond_to do |format|
      format.json do
        dataset_name = "swapi-#{params[:things]}-#{params[:id]}"
        data = DataSet.get(dataset_name)
        logger.debug(data.inspect)
        if data.blank?
          url = "https://swapi.co/api/#{params[:things]}/#{params[:id]}/"
          uri = URI(url)
          response = Net::HTTP.get(uri)
          thing = JSON.parse(response)
          thing_url = thing['url'].split('/api/').last.chop
          thing_id = thing_url.sub('/','-')
          thing_url = "/swapi/#{thing_url}.json"
          thing['id'] = id
          thing['url'] = thing_url
          %w(species characters vehicles people starships planets films).each do |subthing|
            if thing[subthing]
              thing[subthing] = thing[subthing].map { |url| "/swapi/" + url.split('/api/').last.chop + ".json"}
            end
          end
          if thing['homeworld'].present?
            thing['homeworld'] =  "/swapi/" + thing['homeworld'].split('/api/').last.chop + ".json"
          end
          DataSet.create(data: thing.to_json, url: thing['url'], name: "swapi-#{thing_id}", ttl: 0)
        end
        render json: data
      end
    end
  end

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
        logger.debug(data.inspect)
        if data.blank?
          url = "https://swapi.co/api/#{things}/"
          uri = URI(url)
          response = Net::HTTP.get(uri)
          data = JSON.parse(response)['results']
          data.each_with_index do |thing, index|
            thing_url = thing['url'].split('/api/').last.chop
            thing_id = thing_url.sub('/','-')
            thing_url = "/swapi/#{thing_url}.json"
            thing['id'] = thing_id
            thing['url'] = thing_url
            %w(species characters vehicles residents people starships planets films).each do |subthing|
              if thing[subthing]
                thing[subthing] = thing[subthing].map { |url| "/swapi/" + url.split('/api/').last.chop + ".json"}
              end
            end
            if thing['homeworld'].present?
              thing['homeworld'] =  "/swapi/" + thing['homeworld'].split('/api/').last.chop + ".json"
            end
            DataSet.create(data: thing.to_json, url: thing['url'], name: "swapi-#{thing_id}", ttl: 0)
          end

          DataSet.create(data: data.to_json, url: "/swapi/#{things}.json", name: dataset_name, ttl: 0)
        end

        render json: data
      end
    end
  end

end
