class RenameTableDoctorProfiles < ActiveRecord::Migration[5.1]
  def change
    rename_table :doctor_profiles, :user_profiles
  end
end
