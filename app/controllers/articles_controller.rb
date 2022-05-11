class ArticlesController < ApplicationController
    before_action :require_user_logged_in!

    def index
        @articles = Article.limit(10)
    end

    def show
        @article = Article.find(params[:id])
    end
end    