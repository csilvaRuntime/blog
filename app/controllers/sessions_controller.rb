class SessionsController < ApplicationController
    skip_before_action :set_current_user, except: [:destroy]

def new
end

def create
    user = User.find_by(email: params[:session][:email])
    if user && user.active? && user.authenticate(params[:session][:email], params[:session][:password])
        session[:user_id] = user.id
        redirect_to articles_path
        if !user.admin? && user.needs_to_update_password?(user.id)
            user.update(state: "inactive")
            flash[:alert] = "For security reasons you have to change your password every 30 seconds"
        end
    else
        render 'new'
    end
end

def destroy 
    session[:user_id] = nil
    flash[:notice] = "Session ended"
    redirect_to root_path
end
    
end
