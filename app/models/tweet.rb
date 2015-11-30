class Tweet < ActiveRecord::Base
  validates :content, uniqueness: true
end
