json.extract! station, :id,
                              :company,
                              :free_bikes,
                              :empty_slots,
                              :slots,
                              :name,
                              :latitude,
                              :longitude,
                              :created_at,
                              :updated_at,
                              :citybik_station_uid,
                              :citybik_station_id
json.url station_url(station, format: :json)
