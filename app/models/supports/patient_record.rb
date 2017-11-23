class Supports::PatientRecord
  attr_reader :patient_record
  
  def initialize patient_record
    @patient_record = patient_record
  end

  def province_options
    @province_options ||= Province.name_asc.pluck :name, :id
  end

  def district_options
    if @patient_record.province.present?
      @patient_record.province.districts.name_asc.pluck :name, :id
    else
      []
    end
  end
end
