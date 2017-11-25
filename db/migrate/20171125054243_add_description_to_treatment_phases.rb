class AddDescriptionToTreatmentPhases < ActiveRecord::Migration[5.1]
  def change
    add_column :treatment_phases, :description, :text
  end
end
