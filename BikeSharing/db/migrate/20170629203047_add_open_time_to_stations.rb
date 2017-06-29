class AddOpenTimeToStations < ActiveRecord::Migration[5.1]
  def change
    add_column :stations, :open_time, :datetime
    add_column :stations, :close_time, :datetime
  end
end
