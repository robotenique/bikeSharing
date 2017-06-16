json.extract! station, :id, :company, :free_bikes, :free_slots, :name, :lat, :long, :created_at, :updated_at
json.url station_url(station, format: :json)
