class Station < ApplicationRecord
  has_one :position, :dependent => :destroy
  has_many :open_times, :dependent => :destroy


  # Used to pass (lat, long) through json.
  # @latitude = @longitude = nil
  # attr_accessor :latitude, :longitude

  # gets all open times in db and return as a hash as following:
  # {
  #    ---- an allowed dow
  #    |
  #    v
  #   "sat" : $open_time_for_saturday
  #    ...
  # }
  # see OpenTime.allowed_dow for proper keys
  def o_times dow
    return open_times.find_by dow: dow
  end
end
