class AddPublicTokenToPatientRecord < ActiveRecord::Migration[5.1]
  def change
    add_column :patient_records, :public_token, :string
  end
end
