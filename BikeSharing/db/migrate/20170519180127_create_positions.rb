class CreatePositions < ActiveRecord::Migration[5.1]
  def change
    create_table :positions do |t|
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
