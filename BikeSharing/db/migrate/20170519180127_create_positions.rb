class CreatePositions < ActiveRecord::Migration[5.1]
  def change
    create_table :positions do |t|
      t.float :lat
      t.float :long

      t.references :imageable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
