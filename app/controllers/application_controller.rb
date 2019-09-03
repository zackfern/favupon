class ApplicationController < ActionController::Base
  # Public: Set the current user in the session.
  def current_user=(user)
    session[:current_user] = user
  end

  # Public: Get the current user in the session.
  def current_user(user)
    session[:current_user]
  end
  helper_method :logged_in?

  # Public: Determine if a user is logged in.
  def logged_in?
    session[:current_user].present?
  end
  helper_method :logged_in?
end
