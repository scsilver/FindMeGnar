class Resort < ActiveRecord::Base
  attr_accessor :distance_text, :distance_value

  def self.sort_by_distance(resorts)
    resorts.sort_by &:distance_value
  end

  def add_distance(json)
    if json['status'] == 'ZERO_RESULTS'
      self.distance_text = 'No Result'
      self.distance_value = 100_000_000_000
    else
      self.distance_text = json['distance']['text']
      self.distance_value = json['distance']['value']
    end
  end
end
