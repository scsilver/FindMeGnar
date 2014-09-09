class GetStats
  attr_accessor :api_key
  def initialize
    self.api_key = 'f8096e4064a18bec'
  end
  def self.update(r)
      @json_t = json(r.address)
      if @json_t["response"]["error"] == nil then
        r.temp = @json_t["current_observation"]["temp_f"]
      else
        r.temp = 'error'
      end
  end
  def self.url(address)
    "http://api.wunderground.com/api/f8096e4064a18bec/conditions/q/CO/#{CGI.escape address.slice(0..(address.index(',')-1))}.json"
  end

  def self.json(address)
    @json = HTTParty.get url(address)
  end

end
