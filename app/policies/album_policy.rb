class AlbumPolicy < ApplicationPolicy 
  def add_images?
    can_modify?
  end

  private
  def can_modify?
    user && user.doctor? && 
      user.clinic.id == record.treatment_phase.patient_record.clinic_id
  end
end
