json.array!(@resorts) do |resort|
  json.extract! resort, :id, :name, :base, :temp, :snowfall, :gnarlocity
  json.url resort_url(resort, format: :json)
end
