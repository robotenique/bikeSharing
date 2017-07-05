class AlreadyBookmarked < ActiveModel::Validator
  def validate(record)
    user = record.user.id
    station = record.station.id
    if BookmarkStation.find_by(station_id: station, user_id: user)
      record.errors[:base] << "Already bookmarked."
    end
  end
end

class BookmarkStation < ApplicationRecord
  belongs_to :user
  belongs_to :station
  validates_with AlreadyBookmarked
end