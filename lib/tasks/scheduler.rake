desc "Import resorts from a JSON file"
task :resorts => :environment do
  json = JSON.parse(File.read('Resorts.json'))
  json.each { |json| Resort.create(json) }
end

desc "Import tweets"
task :gettwit => :environment do
  	client = Twitter::REST::Client.new do |config|
  	config.consumer_key        = "sHYZw1pbZFh8IXOajTg9bQ75I"
  	config.consumer_secret     = "eNGiUWSaXpIsSREmAKyqbMY0KfyMgua70APJcboipqLm8plxl0"
  	config.access_token        = "2784793124-APKuoXpi5VQYJKrzct1PuTDyrYlEGYqIhCt0wBf"
  	config.access_token_secret = "d72lBVSmeve18Vzssu44lUjUq2XPAgx8VLCz15Nw4SkFW"
	end

	client.search("Keystone OR Breckenridge OR Vail OR Abasin Ski", :result_type => "recent").take(10).each do |tweet|  	
        Tweet.create(user: tweet.user.screen_name, content: tweet.text)
	end
    	

end

desc "Update Weather Batch 1 of 3"
task :weather_update_1 => :environment do
  if ([0,2,4,6,8,10,12,14,16,18,20,22].include?(Time.now.hour))	
	GetStats.weather_update_1
  end
end

desc "Update Weather Batch 2 of 3"
task :weather_update_2 => :environment do
  if ([0,2,4,6,8,10,12,14,16,18,20,22].include?(Time.now.hour))	
  	GetStats.weather_update_2
  end
end

desc "Update Weather Batch 3 of 3"
task :weather_update_3 => :environment do
  if ([0,2,4,6,8,10,12,14,16,18,20,22].include?(Time.now.hour))	
  	GetStats.weather_update_3
  end
end

desc "Update Snow Conditions"
task :snow_update => :environment do
  GetStats.update_snow_stats
end
