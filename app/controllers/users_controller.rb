class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def show
    end

    def index
        @users = User.all
    end
    
    #if admin
    def new
        @user = User.new
    end

    def edit
    end

    #if admin
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "User created successfully"
            redirect_to @user
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def update
        if !params[:user][:password_new].present? || @user.password == params[:user][:password_old]
            params[:user][:password] = params[:user][:password_new] if params[:user][:password_new].present?
            #TODO
            if @user.update(user_params)
                flash[:notice] = "User updated successfully"
                redirect_to @user
            else
                render 'edit', status: :unprocessable_entity
            end
        else
            flash.now.alert = "Old password not correct"
            render 'edit', status: :unprocessable_entity
        end
    end

    def destroy
        @user.destroy
        redirect_to users_path
    end

    def user_articles
        current_user = User.find_by_id(session[:current_user_id])
        @articles = Article.where(user_id: current_user)
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :name, :email, :password, :user_role, :state)
    end

end