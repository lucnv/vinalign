class AddSharingFlagToPatientRecord < ActiveRecord::Migration[5.1]
  def change
    add_column :patient_records, :is_sharing, :boolean, default: false
  end
end
