class UpdateLocalStations
  def self.update
    ApiController.get_sampa_stations.each do |remote_station|
      update_single_station remote_station
    end
  end

  private
  def self.update_single_station(remote_station)
    # if (CitybikApiStation.id remote_station) == '279377798a8f6d4ad026fb518cbba9c3'
    #   puts 'buscando no bd local estacao'
    #   puts "\t #{CitybikApiStation.station_name remote_station}"
    #   puts "\t #{CitybikApiStation.id remote_station}"
      local_station = Station.find_by('name', CitybikApiStation.station_name(remote_station))
      if local_station == nil
        save_new_remote_station remote_station
      else
        update_local_station_from_remote_station local_station, remote_station
      end
    # end
  end

  def self.update_local_station_from_remote_station local_station, remote_station
    puts "Updating station #{local_station.citybik_station_id}"
    local_station.free_bikes = CitybikApiStation.free_bikes remote_station
    local_station.empty_slots = CitybikApiStation.empty_slots remote_station
    local_station.save!
  end

  def self.save_new_remote_station remote_station
    new_station = build_local_station_from_remote_station remote_station
    new_station.save!
  end

  def self.build_local_station_from_remote_station remote_station
    puts "Saving station #{CitybikApiStation.id remote_station}"
    new_station = Station.new
    new_station.name = CitybikApiStation.station_name remote_station
    new_station.citybik_station_id = CitybikApiStation.id remote_station
    new_station.citybik_station_uid = CitybikApiStation.uid remote_station
    new_station.slots = CitybikApiStation.slots remote_station
    new_station.latitude = CitybikApiStation.latitude remote_station
    new_station.longitude = CitybikApiStation.longitude remote_station
    new_station.free_bikes = CitybikApiStation.free_bikes remote_station
    new_station.empty_slots = CitybikApiStation.empty_slots remote_station
    # new_station.status = CitybikApiStation.status remote_station
    # new_station.company = CitybikApiStation.company remote_station
    new_station
  end
end