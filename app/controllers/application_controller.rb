class ApplicationController < ActionController::Base
  # Public: Set the current user in the session.
  def current_user=(user)
    session[:current_user_id] = user.id
  end

  # Public: Get the current user in the session.
  def current_user
    @current_user ||= User.find(session[:current_user_id])
  end
  helper_method :current_user

  # Public: Determine if a user is logged in.
  def logged_in?
    session[:current_user_id].present?
  end
  helper_method :logged_in?
end
