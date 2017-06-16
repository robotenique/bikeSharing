class CreateStations < ActiveRecord::Migration[5.1]
  def change
    create_table :stations do |t|
      t.string :company
      t.integer :free_bikes
      t.integer :slots
      t.string :name
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
