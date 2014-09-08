namespace :import do
  desc "Import resorts from a JSON file"
  task :resorts => :environment do
    json = JSON.parse(File.read('Resorts.json'))
    json.each { |json| Resort.create(json) }
  end
end
