class StationHistoryMaintainer
  def self.fetch_and_insert
    remote_stations = ApiController.get_sampa_stations
    remote_stations.each do |remote_station|
      local_station = Station.find_by_citybik_station_id(CitybikApiStation.id(remote_station))
      continue if local_station == nil
      station_history_single_data = StationHistory.new
      station_history_single_data.free_bikes = CitybikApiStation.free_bikes remote_station
      station_history_single_data.free_slots = CitybikApiStation.empty_slots remote_station
      # station_history_single_data.rate = station_history_single_data.
      station_history_single_data.station = local_station
      station_history_single_data.save!
    end
  end
end
