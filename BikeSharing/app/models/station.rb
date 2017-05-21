class Station < ApplicationRecord
  has_one :position

  @latitude = @longitude = nil
  attr_accessor :latitude, :longitude
end
