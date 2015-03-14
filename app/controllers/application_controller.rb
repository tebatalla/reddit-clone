class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def log_in!(user)
    user.reset_session_token!
    self.session[:token] = user.session_token
  end

  def log_out!(user)
    self.session[:token] = nil
    user.reset_session_token!
    redirect_to new_session_url
  end

  def current_user
    return nil if self.session[:token].nil?
    @current_user = User.find_by_session_token(self.session[:token])
  end

end
