class AddIndexPublicTokenPatientRecords < ActiveRecord::Migration[5.1]
  def change
    add_index :patient_records, :public_token, unique: true
  end
end
