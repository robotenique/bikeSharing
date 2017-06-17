class CreateStations < ActiveRecord::Migration[5.1]
  def change
    create_table :stations do |t|
      t.string :company
      t.integer :free_bikes
      t.integer :empty_slots
      t.integer :slots
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :citybik_station_id
      t.string :citybik_station_uid

      t.timestamps
    end
  end
end
