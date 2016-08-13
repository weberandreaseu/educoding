class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def update_solution(solution)
    if solution.update_attributes(solution_params.except(:filename))
      redirect_to tasks_path, notice: 'Solution was updated'
    else
      redirect_to edit_solution_path(solution)
    end
  end

  def run_solution(solution)
    solution.assign_attributes(solution_params)
    respond_to do |format|
      format.js
    end
  end

  private

  def set_locale
    I18n.locale = params[:locale]
  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

  def locale_path(locale)
    locale_regexp = %r{/(en|de)/?}
    if request.env['PATH_INFO'] =~ locale_regexp
      "#{request.env['PATH_INFO']}".gsub(locale_regexp, "/#{locale}/")
    else
      "/#{locale}#{request.env['PATH_INFO']}"
    end
  end

  helper_method :locale_path
end