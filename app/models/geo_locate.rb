class GeoLocate
  attr_accessor :address, :api_key

  def initialize(address)
    self.address = address
    self.api_key = \
      'AIzaSyBb3ZSbRxq6PQSsJmpTT9bR79HghrI9_LE'
  end

  def address_param
    CGI.escape address
  end

  def destination_param
    CGI.escape resorts.map(&:address).join('|')
  end

  def locate
    resorts.each_with_index do |resort, i|
      resort.add_distance \
        distance_from['rows'][0]['elements'][i]
    end
    # GetStats.update(resort)
    Resort.sort_by_distance resorts
  end

  def resorts
    @resorts ||= Resort.all
  end

  def distance_from
    @distance_from ||= HTTParty.get url
  end

  def url
    url = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=#{address_param}&destinations=#{destination_param}&key=#{api_key}&units=imperial"
  end
end
