class CreateTreatmentPlanFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :treatment_plan_files do |t|
      t.string :source
      t.references :treatment_phase, foreign_key: true

      t.timestamps
    end
  end
end
