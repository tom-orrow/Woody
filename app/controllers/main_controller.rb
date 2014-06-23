class MainController < ApplicationController
  def index
    @projects = Project.all()
    @categories = Category.all()
    @articles = Article.limit(4)
  end

  def show
    @article = Article.friendly.find(params[:id])
    @article_prev = @article.prev
    @article_next = @article.next

  end

  def load_more_articles
    per_page = 4
    @articles = Article.limit(per_page).offset(per_page * params[:articles_page].to_i)
    render status: 500 if @articles.count == 0

    render partial: "articles_load_more"
  end
end
