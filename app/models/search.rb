class Search
  include ActiveModel::Model
  attr_accessor :location

  def resorts
    GeoLocate.locate(location)
  end
end
