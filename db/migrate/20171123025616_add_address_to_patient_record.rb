class AddAddressToPatientRecord < ActiveRecord::Migration[5.1]
  def change
    add_column :patient_records, :address, :string
  end
end
