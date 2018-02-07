class Supports::Expert
  attr_reader :expert

  def initialize expert = nil
    @expert = expert
  end

  def province_options
    @province_options ||= Province.name_asc.pluck :name, :id
  end

  def district_options
    if expert.province.present?
      expert.province.districts.name_asc.pluck :name, :id
    else
      []
    end
  end
end
