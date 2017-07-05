class CreateBookmarkStations < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmark_stations do |t|

      t.timestamps
    end
  end
end
