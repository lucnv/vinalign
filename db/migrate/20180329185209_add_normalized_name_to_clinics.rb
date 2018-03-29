class AddNormalizedNameToClinics < ActiveRecord::Migration[5.1]
  def change
    add_column :clinics, :normalized_name, :string
  end
end
