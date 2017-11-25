class RemoveClinicIdFromUserProfiles < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_profiles, :clinic_id
  end
end
