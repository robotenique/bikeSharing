class CreateOpenTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :open_times do |t|
      t.time :open
      t.time :close
      t.string :dow
      t.integer :station_id

      t.timestamps
    end
    add_index :open_times, :station_id # TODO: change this
  end
end
