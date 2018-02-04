class Supports::Clinic
  attr_reader :clinic

  def initialize clinic = nil
    @clinic = clinic
  end

  def province_options
    @province_options ||= Province.name_asc.pluck :name, :id
  end

  def district_options
    if @clinic.province.present?
      @clinic.province.districts.name_asc.pluck :name, :id
    else
      []
    end
  end
end
