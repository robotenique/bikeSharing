class AddStationRefToBookmarkStation < ActiveRecord::Migration[5.1]
  def change
    add_reference :bookmark_stations, :station, foreign_key: true
  end
end
