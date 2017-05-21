class Station < ApplicationRecord
  has_one :position, as: :imageable, :dependent => :destroy

  @latitude = @longitude = nil
  attr_accessor :latitude, :longitude
end
