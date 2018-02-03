class Supports::Clinic
  attr_reader :clinic

  def initialize patient_record = nil
    @patient_record = patient_record
  end

  def province_options
    @province_options ||= Province.name_asc.pluck :name, :id
  end
end
