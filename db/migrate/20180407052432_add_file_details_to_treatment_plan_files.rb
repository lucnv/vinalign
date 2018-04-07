class AddFileDetailsToTreatmentPlanFiles < ActiveRecord::Migration[5.1]
  def change
    add_column :treatment_plan_files, :file_name, :string
    add_column :treatment_plan_files, :content_type, :string
    add_column :treatment_plan_files, :file_size, :integer
  end
end
