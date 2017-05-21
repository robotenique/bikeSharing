class AddPositionRefToStation < ActiveRecord::Migration[5.1]
  def change
    add_reference :stations, :position, foreign_key: true
  end
end
