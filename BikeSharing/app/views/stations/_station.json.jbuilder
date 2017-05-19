json.extract! station, :id, :name, :free_slots, :free_bikes, :company, :created_at, :updated_at
json.url station_url(station, format: :json)
