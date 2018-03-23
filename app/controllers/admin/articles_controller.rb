class Admin::ArticlesController < Admin::BaseController
  def index
    @q = Article.ransack params[:q]
    @articles = @q.result.recent_created.page(params[:page]).per(Settings.articles.per_page)
  end
end
