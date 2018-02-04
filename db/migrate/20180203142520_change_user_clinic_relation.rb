class ChangeUserClinicRelation < ActiveRecord::Migration[5.1]
  def change
    remove_reference :clinics, :user, foreign_key: true
    add_reference :user_profiles, :clinic, foreign_key: true
  end
end
