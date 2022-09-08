class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]

    def show
    end

    def drafts
        @articles = Article.is_draft
    end

    def pending
        @articles = Article.is_pending
    end

    def index
        @articles = Article.is_submitted
    end

    def new
        @article = Article.new
    end

    def edit
    end

    def create
        params[:article][:user_id] = @current_user.id
        @article = Article.new(article_params)
        if @article.save
            flash[:notice] = "Article created successfully"
            redirect_to @article
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def update
        if @article.update(article_params)
            flash[:notice] = "Article updated successfully"
            @article.edit_count += 1
            @article.update(edit_count: @article.edit_count)
            redirect_to @article
        else
            render 'edit', status: :unprocessable_entity
        end
    end

    def destroy
        @article.destroy
        redirect_to articles_path
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :text, :state, :user_id)
    end

end