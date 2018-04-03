class ArticleSearch
  include ActiveModel::Model

  attr_accessor :title, :category_eq, :created_at_month

  RANSACK_ATTRIBUTES = [:category_eq]
  SEARCHABLE_ATTRIBUTES = [:title, :created_at_month] + RANSACK_ATTRIBUTES

  def result scope = Article.all
    search_params = RANSACK_ATTRIBUTES.inject({}) do |params, attribute|
      params.merge attribute => public_send(attribute)
    end
    if created_at_month.present?
      self.created_at_month = Time.parse(self.created_at_month + "-01")
    end
    search_params.merge! created_at_month: self.created_at_month.to_s
    scope = scope.search_by_title(title) if title.present?
    scope.ransack(search_params).result
  end
end
