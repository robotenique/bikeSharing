json.extract! station, :id, :company, :free_bikes, :slots, :name, :lat, :long, :created_at, :updated_at
json.url station_url(station, format: :json)
