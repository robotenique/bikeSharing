class AddUserRefToBookmarkStation < ActiveRecord::Migration[5.1]
  def change
    add_reference :bookmark_stations, :user, foreign_key: true
  end
end
