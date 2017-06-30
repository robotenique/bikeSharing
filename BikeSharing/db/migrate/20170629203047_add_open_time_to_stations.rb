class AddOpenTimeToStations < ActiveRecord::Migration[5.1]
  def change
    add_column :stations, :open_time, :time
    add_column :stations, :close_time, :time
  end
end
