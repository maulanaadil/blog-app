class ArticlesController < ApplicationController
    before_action :require_user_logged_in!

    def index
        @articles = Article.limit(10)
    end

    def show
        @article = Article.find(params[:id])
    end

    def new
        @article = Article.new
        @categories = Category.ids
    end

    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to articles_path, notice: "Tweet was scheduled successfully"
        else
            render :new 
        end  
    end
    

    def hobby
        articles_for_branch(params[:action])
    end

    def study
        articles_for_branch(params[:action])
    end

    def team
        articles_for_branch(params[:action])
    end

    private
    def articles_for_branch(branch)
        @categories = Category.where(branch: branch)
        @articles = get_articles.paginate(page: params[:page])
    end

    def get_articles
        Article.limit(30)
    end

    def article_params
        params.require(:article).permit(:content, :title, :category_id).merge(user_id: current_user.id)
    end   
    
end    