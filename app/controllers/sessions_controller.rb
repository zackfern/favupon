class SessionsController < ApplicationController
  def index
    redirect_to favorite_tweets_path and return if logged_in?
  end

  def new
    redirect_to "/auth/twitter"
  end

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    redirect_to '/'
  end

  def destroy
    reset_session
    redirect_to :root
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
