class Search
  include ActiveModel::Model
  validates :location, presence: true
  
  attr_accessor :location
  def geolocater
    GeoLocate.new(location)
  end
  def resorts
    @resorts ||= geolocater.locate
  end
end
