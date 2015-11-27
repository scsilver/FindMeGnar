

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
    mechanize = Mechanize.new
    @resorts = Resort.all

    @resorts.each do |resort|
      if resort['scrape_url'] != ""
        page = mechanize.get(resort['scrape_url'])
      end
      if resort['scrape_xpath_24hr'] != ""
        resort['snowfall'] = page.search(CGI.unescapeHTML(resort['scrape_xpath_24hr']+"/text()")).to_s.chomp(' \"').to_i
      end
      if resort['scrape_xpath_base'] != ""
        resort['base'] = page.search(CGI.unescapeHTML(resort['scrape_xpath_base']+"/text()")).to_s.chomp(' \"').to_i
      end
     # if resort['scrape_xpath_temp'] != ""
     #  resort['temp'] = page.search(CGI.unescapeHTML(resort['scrape_xpath_temp']+"/text()")).to_s.chomp(' \"').to_i
    #  end
      #CSV.open("resorts_data.csv", "a+") do |csv_file|
      #    csv_file <<([resort['name'],resort['snowfall'],resort['site'],resort['xpath']])
      #end
      resort.save
    end
  end


end
