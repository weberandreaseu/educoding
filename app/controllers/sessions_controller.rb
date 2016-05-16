class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      # TODO: extrak to log_in user in session_helper
      session[:user_id] = user.id
      redirect_to root_path, notice: "You are logged in"
      
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You are logged out"
  end
end
