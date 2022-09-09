class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :set_tags, only: [:index, :new, :edit]

    def show
    end

    def my_articles
        @articles = Article.where(user_id: @current_user)
    end

    def index
        if params[:state]
            @articles = Article.where(:state => params[:state])
        else
            @articles = Article.all
        end
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
            MailJob.set(wait: 1.minutes).perform_later(@article.user_id)
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

    def set_tags
        @tags = Tag.all
    end

    def article_params
        params.require(:article).permit(:title, :text, :state, :user_id, article_tags_attributes: [:tag_id])
    end

end
