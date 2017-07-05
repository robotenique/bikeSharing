class Station < ApplicationRecord
  has_many :station_histories
  has_many :bookmark_stations
  has_many :users, through: :bookmark_stations
end
