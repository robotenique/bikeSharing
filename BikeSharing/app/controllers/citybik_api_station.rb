class CitybikApiStation

  @station_methods = [
      :empty_slots,
      :free_bikes,
      :id,
      :latitude,
      :longitude,
      :station_name,
      :timestamp,
      :address,
      :slots,
      :status,
      :uid
  ]

  def self.station_methods
    @station_methods
  end

  def self.empty_slots(station)
    station['empty_slots']
  end
  def self.free_bikes(station)
    station['free_bikes']
  end
  def self.id(station)
    station['id']
  end
  def self.latitude(station)
    station['latitude']
  end
  def self.longitude(station)
    station['longitude']
  end
  def self.station_name(station)
    station['name']
  end
  def self.timestamp(station)
    station['timestamp']
  end

  @extra = 'extra'
  def self.address(station)
    station[@extra]['address']
  end
  def self.slots(station)
    station[@extra]['slots']
  end
  def self.status(station)
    station[@extra]['status']
  end
  def self.uid(station)
    station[@extra]['uid']
  end
end