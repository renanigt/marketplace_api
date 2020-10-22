class CreatePlacements < ActiveRecord::Migration[6.0]
  def change
    create_table :placements do |t|
      t.belongs_to :order
      t.belongs_to :product

      t.timestamps
    end
  end
end
