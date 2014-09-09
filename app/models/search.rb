class Search
  include ActiveModel::Model
  attr_accessor :location
  def geolocater
    GeoLocate.new(location)
  end
  def resorts
    @resorts ||= geolocater.locate
  end
end
