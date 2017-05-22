class Station < ApplicationRecord
  has_one :position, as: :imageable, :dependent => :destroy

  has_many :open_times, :dependent => :destroy

  # Used to pass (lat, long) through json.
  @latitude = @longitude = nil
  attr_accessor :latitude, :longitude
end
