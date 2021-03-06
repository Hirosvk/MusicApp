class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login!(user)
    user.reset_session_token!
    @current_user = user
    session[:session_token] = user.session_token
  end


  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logout!
    current_user.reset_session_token! unless current_user.nil?
    session[:session_token] = nil
  end

  def require_login
    flash[:errors] = "You need to be logged in to use this feature."
    redirect_to bands_url if current_user.nil?
  end

  helper_method :current_user

end
