json.extract! station, :id, :company, :free_bikes, :free_slots, :slots, :name, :latitude, :longitude, :created_at, :updated_at
json.url station_url(station, format: :json)
