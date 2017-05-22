class CreatePositions < ActiveRecord::Migration[5.1]
  def change
    create_table :positions do |t|
      t.float :lat
      t.float :long

      # This polymorphic association is intended to be used with Station and
      # some other structures to be coded yet
      t.references :imageable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
