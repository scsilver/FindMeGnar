class GetStats
  attr_accessor :api_key
  def initialize
    self.api_key = 'f8096e4064a18bec'
  end
  def self.update(r)
      @json_t = json(r.stationid)
      if @json != nil then
        r.base = @json["data"][1]["Snow Depth (in)"]

       # r.temp = @json_t["current_observation"]["temp_f"]
      else
        r.temp = 'error'
      end
  end
  def self.url(stationid)
    apiurl = "http://api.powderlin.es/station/#{CGI.escape stationid}"
  end

  def self.json(stationid)
    @json = HTTParty.get url(stationid)
  end

end
