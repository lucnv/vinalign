class PatientRecordSearch
  include ActiveModel::Model

  attr_accessor :full_name, :gender_eq, :start_date_from

  RANSACK_ATTRIBUTES = [:gender_eq]
  SEARCHABLE_ATTRIBUTES = [:full_name, :start_date_from] + RANSACK_ATTRIBUTES

  def result scope = PatientRecord.all
    search_params = RANSACK_ATTRIBUTES.inject({}) do |params, attribute|
      params.merge attribute => public_send(attribute)
    end
    if self.start_date_from.present?
      self.start_date_from = Time.parse self.start_date_from
    end
    search_params.merge! start_date_from: self.start_date_from.to_s
    scope = scope.search_by_full_name(full_name) if full_name.present?
    scope.ransack(search_params).result
  end
end
