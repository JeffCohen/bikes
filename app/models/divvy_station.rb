class DivvyStation

  # Input: a string of an address, i.e. "5555 S. Ellis Ave, Chicago, IL"
  # Returns: a hash containing the data of the nearest Divvy station
  def DivvyStation.find_nearest_station(address)
    location = geocode(address)

    DivvyStation.all.min do |station1, station2|
      distance1 = distance_from(station1, location)
      distance2 = distance_from(station2, location)
      distance1 <=> distance2
    end

  end

  # Input: a string of an address, i.e. "5555 S. Ellis Ave, Chicago, IL"
  # Returns: a hash containing geocode data (latitidue and longitude).
  def DivvyStation.geocode(address)
    encoded_address = URI.encode(address)
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{encoded_address}&key=AIzaSyC-yYPhcpquyNen8Drrfwa-DXQxnXTugYc"
    data = JSON.parse(open(url).read)
    Rails.logger.debug data.inspect
    return data['results'].first['geometry']['location']
  end

  # Input: two geocode hashes
  # Returns: the distance between the two points
  def DivvyStation.distance_from(station, point)
    Math.sqrt( (station['latitude'] - point['lat'])**2 +
    (station['longitude'] - point['lng'])**2 )
  end

  # Returns a list of all Divvy stations.
  def DivvyStation.all
    @data ||= begin
      data = DataSet.get('divvy')
      # data.map do |station|
      #   { "id" => station['id'],
      #     "name" => station['stationName'],
      #     "lat" => station['latitude'],
      #     "lng" => station["longitude"],
      #     "availableBikes" => station["availableBikes"] }
      # end
    end
  end

end
