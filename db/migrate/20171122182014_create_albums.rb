class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.references :treatment_phase, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
