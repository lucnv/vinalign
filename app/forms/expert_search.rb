class ExpertSearch
  include ActiveModel::Model

  attr_accessor :full_name, :workplace, :province_id_eq

  RANSACK_ATTRIBUTES = [:province_id_eq]
  SEARCHABLE_ATTRIBUTES = [:full_name, :workplace] + RANSACK_ATTRIBUTES

  def result scope = Expert.all
    search_params = RANSACK_ATTRIBUTES.inject({}) do |params, attribute|
      params.merge attribute => public_send(attribute)
    end
    scope = scope.search_by_full_name(full_name) if full_name.present?
    scope = scope.search_by_workplace(workplace) if workplace.present?
    scope.ransack(search_params).result
  end
end
