class GetStats
def self.weather_update_1
  @resorts = Resort.where(:id => 1..7)
  @resorts.each do |r|
  apikey = 'f8096e4064a18bec'
  url = "http://api.wunderground.com/api/#{apikey}/conditions/q/#{r.address}.json"
  @results = HTTParty.get url
  r.temp = @results["current_observation"]["temp_f"]
  r.save
        #r.snowfallforecast
    end
end
def self.weather_update_2
  @resorts = Resort.where(:id => 7..15)
  @resorts.each do |r|
  apikey = 'f8096e4064a18bec'
  url = "http://api.wunderground.com/api/#{apikey}/conditions/q/#{r.address}.json"
  @results = HTTParty.get url
  r.temp = @results["current_observation"]["temp_f"]
  r.save
        #r.snowfallforecast
    end
end
def self.weather_update_3
  @resorts = Resort.where(:id => 15..22)
  @resorts.each do |r|
  apikey = 'f8096e4064a18bec'
  url = "http://api.wunderground.com/api/#{apikey}/conditions/q/#{r.address}.json"
  @results = HTTParty.get url
  r.temp = @results["current_observation"]["temp_f"]
  r.save
        #r.snowfallforecast
    end
end
  
  
  
  
  
  
  def self.update_snow_stats
    urls = "http://www.onthesnow.com/colorado/snow-rss.html"
    feeds = Feedjira::Feed.fetch_and_parse urls
    feeds.entries.first(22).each_with_index do |r, i|
      name = r.title[/(.*)\s/,1]
      resort = Resort.find_by(name: name)
      resort.snowfall = r.summary.slice(40..42)
      resort.base = r.summary.slice(88..91)
      resort.save
      end
     # if @json != nil then
      #  r.base = @json["data"][1]["Snow Depth (in)"]

     # else
     # end
  end
end
