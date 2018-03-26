class PagesController < ApplicationController
  def show
    @articles = Article.news.recent_created.limit(Settings.front.carousel.news.limit)
    render template: "pages/#{params[:page]}"
  end
end
