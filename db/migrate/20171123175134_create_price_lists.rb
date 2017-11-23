class CreatePriceLists < ActiveRecord::Migration[5.1]
  def change
    create_table :price_lists do |t|
      t.references :patient_record, foreign_key: true
      t.string :item
      t.integer :price

      t.timestamps
    end
  end
end
