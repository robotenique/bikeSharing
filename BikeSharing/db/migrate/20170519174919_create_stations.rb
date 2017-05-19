class CreateStations < ActiveRecord::Migration[5.1]
  def up
    create_table :stations do |t|
      t.string :name
      t.integer :free_slots
      t.integer :free_bikes
      t.string :company

      t.timestamps
    end
  end
  def down
    drop_table :stations
  end
end
