class CreateStationHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :station_histories do |t|
      t.integer :free_slots
      t.integer :free_bikes
      t.float :rate

      t.timestamps
    end
  end
end
