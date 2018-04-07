class ArticlesController < ApplicationController
  def show
    @article = Article.friendly_find params[:id]
    @related_articles = Article.by_category(@article.category).where.not(id: @article.id)
      .recent_created.limit Settings.articles.related_on_page
  end
end
