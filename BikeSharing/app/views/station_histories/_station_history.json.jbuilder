json.extract! station_history, :id, :free_slots, :free_bikes, :rate, :citybik_station_id, :created_at, :updated_at
json.url station_history_url(station_history, format: :json)
