class ArticleSearch
  include ActiveModel::Model

  attr_accessor :title, :category_eq

  RANSACK_ATTRIBUTES = [:category_eq]
  SEARCHABLE_ATTRIBUTES = [:title] + RANSACK_ATTRIBUTES

  def result scope = Article.all
    search_params = RANSACK_ATTRIBUTES.inject({}) do |params, attribute|
      params.merge attribute => public_send(attribute)
    end
    scope = scope.search_by_title(title) if title.present?
    scope.ransack(search_params).result
  end
end
