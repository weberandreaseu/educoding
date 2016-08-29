class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:sessions][:email]&.downcase)
    if user && user.authenticate(params[:sessions][:password])
      # TODO: extrak to log_in user in session_helper
      session[:user_id] = user.id
      redirect_to tasks_path, notice: t('messages.valid_login')
    else
      flash.now[:danger] = t('messages.invalid_login')
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: t('messages.logout')
  end
end
