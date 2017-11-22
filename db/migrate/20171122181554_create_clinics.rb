class CreateClinics < ActiveRecord::Migration[5.1]
  def change
    create_table :clinics do |t|
      t.string :name
      t.string :phone_number
      t.references :district, foreign_key: true
      t.string :address
      t.string :website
      t.string :facebook

      t.timestamps
    end
  end
end
