class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  
  def current_user
    #fetches current_user
    return nil if session[:session_token].nil?
    @user ||= User.find_by(session_token: session[:session_token])
  end
  
  def log_in!(user)
    # force other clients to log out when signing in
    user.reset_session_token!
    session[:session_token] = user.session_token
  end
  
  def log_out!
    session[:session_token] = nil
  end
end
