class PagesController < ApplicationController
  def show
    @articles = Article.news.recent_created.limit(Settings.front.carousel.news.limit)
    @home_posts = Article.home.earlier_created
    render template: "pages/#{params[:page]}"
  end
end
