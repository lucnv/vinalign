class AddStatusToTreatmentPlanFiles < ActiveRecord::Migration[5.1]
  def change
    add_column :treatment_plan_files, :doctor_opinion, :integer, default: 0
  end
end
