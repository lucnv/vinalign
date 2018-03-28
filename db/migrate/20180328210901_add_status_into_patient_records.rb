class AddStatusIntoPatientRecords < ActiveRecord::Migration[5.1]
  def change
    add_column :patient_records, :status, :string
  end
end
