class CreatePatientRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :patient_records do |t|
      t.references :clinic, foreign_key: true
      t.date :start_date
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.integer :gender
      t.references :district, foreign_key: true
      t.string :phone_number
      t.string :email
      t.string :fax
      t.string :doctor
      t.string :profile_photo

      t.timestamps
    end
  end
end
