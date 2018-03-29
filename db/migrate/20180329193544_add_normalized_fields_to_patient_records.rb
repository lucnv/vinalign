class AddNormalizedFieldsToPatientRecords < ActiveRecord::Migration[5.1]
  def change
    add_column :patient_records, :normalized_name, :string
  end
end
