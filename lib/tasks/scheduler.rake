desc "Import resorts from a JSON file"
task :resorts => :environment do
  json = JSON.parse(File.read('Resorts.json'))
  json.each { |json| Resort.create(json) }
end

desc "Update Weather Batch 1 of 3"
task :weather_update_1 => :environment do
  GetStats.weather_update_1
end

desc "Update Weather Batch 2 of 3"
task :weather_update_2 => :environment do
  GetStats.weather_update_2
end

desc "Update Weather Batch 3 of 3"
task :weather_update_3 => :environment do
  GetStats.weather_update_3
end

desc "Update Snow Conditions"
task :snow_update => :environment do
  GetStats.update_snow_stats
end
