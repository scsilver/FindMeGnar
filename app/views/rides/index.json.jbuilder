json.array!(@rides) do |ride|
  json.extract! ride, :id, :resort_to, :location_from, :time_start, :time_end, :spots, :contact_info
  json.url ride_url(ride, format: :json)
end
