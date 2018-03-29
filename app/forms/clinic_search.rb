class ClinicSearch
  include ActiveModel::Model

  attr_accessor :name, :province_id_eq

  RANSACK_ATTRIBUTES = [:province_id_eq]
  SEARCHABLE_ATTRIBUTES = [:name] + RANSACK_ATTRIBUTES

  def result scope = Clinic.all
    search_params = RANSACK_ATTRIBUTES.inject({}) do |params, attribute|
      params.merge attribute => public_send(attribute)
    end
    if name.present?
      clinic_ids = Clinic.search_by_name(name).pluck :id
      return Clinic.none unless clinic_ids.present?
      search_params.merge! id_in: clinic_ids
    end
    scope.ransack(search_params).result
  end
end
