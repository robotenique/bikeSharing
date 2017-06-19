class AddStationRefToStationHistory < ActiveRecord::Migration[5.1]
  def change
    add_reference :station_histories, :station, foreign_key: true
  end
end
