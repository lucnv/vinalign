class PatientRecordSearch
  include ActiveModel::Model

  attr_accessor :full_name, :gender_eq, :start_date_gteq, :start_date_lteq

  RANSACK_ATTRIBUTES = [:gender_eq, :start_date_gteq, :start_date_lteq]
  SEARCHABLE_ATTRIBUTES = [:full_name] + RANSACK_ATTRIBUTES

  def result scope = PatientRecord.all
    search_params = RANSACK_ATTRIBUTES.inject({}) do |params, attribute|
      params.merge attribute => public_send(attribute)
    end
    scope = scope.search_by_full_name(full_name) if full_name.present?
    scope.ransack(search_params).result
  end
end
