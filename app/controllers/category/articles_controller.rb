class Category::ArticlesController < ApplicationController
  helper_method :category

  def index
    @articles = Article.by_category(category).recent_created.page(params[:page])
      .per(Settings.articles.per_page_front)
  end

  private
  def category
    params[:category]
  end
end
