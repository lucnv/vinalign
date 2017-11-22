class AddForeignKeyDoctorProfileClinic < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :doctor_profiles, :clinics
  end
end
