class Admin::ArticlesController < Admin::BaseController
  before_action :load_article, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    @article.assign_attributes article_params
    if @article.save
      flash[:success] = t ".success"
      redirect_to admin_articles_path
    else
      flash.now[:failed] = t ".failed"
      render :edit
    end
  end

  def destroy
    if @article.destroy
      flash[:success] = t ".success"
    else
      flash[:failed] = t ".failed"
    end
    redirect_to admin_articles_path
  end

  private
  def article_params
    params.require(:article).permit Article::PERSIST_ATTRIBUTES
  end

  def load_article
    @article = Article.find params[:id]
  end
end
