class GeoLocate
  def self.locate(address)
    api_key = 'AIzaSyBb3ZSbRxq6PQSsJmpTT9bR79HghrI9_LE'
    resorts = Resort.all
    destinations = resorts.map(&:address)
    destination_string = CGI.escape destinations.join("|")
    url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{CGI.escape(address)}&destinations=#{destination_string}=&key=#{api_key}"
    distance_matrix = HTTParty.get url
    resorts.each_with_index do |resort, i|
      resort.distance_text = distance_matrix["rows"][0]["elements"][i]["distance"]["text"]
      resort.distance_value = distance_matrix["rows"][0]["elements"][i]["distance"]["value"]
    end.sort_by &:distance_value
  end
end
