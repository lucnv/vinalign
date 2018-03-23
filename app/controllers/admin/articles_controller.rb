class Admin::ArticlesController < Admin::BaseController
  def index
    @q = Article.ransack params[:q]
    @articles = @q.result.recent_created.page(params[:page]).per(Settings.articles.per_page)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new article_params
    if @article.save
      flash[:success] = t ".success"
      redirect_to admin_articles_path
    else
      flash.now[:failed] = t ".failed"
      render :new
    end
  end

  private
  def article_params
    params.require(:article).permit Article::PERSIST_ATTRIBUTES
  end
end
