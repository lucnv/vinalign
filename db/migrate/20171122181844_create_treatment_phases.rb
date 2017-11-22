class CreateTreatmentPhases < ActiveRecord::Migration[5.1]
  def change
    create_table :treatment_phases do |t|
      t.references :patient_record, foreign_key: true
      t.string :name
      t.date :start_date

      t.timestamps
    end
  end
end
