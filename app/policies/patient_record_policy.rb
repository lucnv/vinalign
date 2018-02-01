class PatientRecordPolicy < ApplicationPolicy
  def show?
    is_own_doctor?
  end

  def edit?
    is_own_doctor?
  end

  def update?
    is_own_doctor?
  end

  def destroy?
    is_own_doctor?
  end

  private
  def is_own_doctor?
    user && user.doctor? && user.clinic_id == record.clinic_id
  end
end
