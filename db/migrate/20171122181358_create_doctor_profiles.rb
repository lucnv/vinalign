class CreateDoctorProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :doctor_profiles do |t|
      t.references :user, foreign_key: true
      t.references :clinic
      t.string :avatar
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.integer :gender
      t.string :phone_number

      t.timestamps
    end
  end
end
