class ArticlesController < ApplicationController
    before_action :require_user_logged_in!
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :check_for_cancel, :only => [:create, :update]

    def index
        query = params[:search]
        query_category = params[:category_id]
        @articles = Article.where("title LIKE ?", "%#{query}%").or(Article.where(category_id: "#{query_category}")).paginate(page: params[:page]).limit(10).order('created_at DESC').all
        @categories = Category.all
    end

    def show
        
    end

    def new
        @article = Article.new
        @category = Category.ids
    end

     def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to articles_path, notice: "Tweet was scheduled successfully"
        else
            render :new 
        end  
    end

    def edit
        
    end

    def update
        if @article.update(article_params)
            redirect_to articles_path, notice: "Article was updated successfully"
        else
            render :edit
        end
    end

    def destroy
        @article.destroy
        redirect_to articles_path, alert: "Article was deleted"
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
        @articles = Article.joins(:category).where(categories: { branch: branch }).paginate(page: params[:page]).order('created_at DESC')
    end

    def get_articles
        Article.limit(10)
    end

    def article_params
        params.require(:article).permit(:content, :title, :category_id).merge(user_id: current_user.id)
    end
    
    def set_article
        @article = Article.find(params[:id])
    end

    def check_for_cancel
        if params[:commit] == "Cancel"
            redirect_to my_page_path
        end
    end
    
end    