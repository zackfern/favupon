class SessionsController < ApplicationController
  def index
    if logged_in?
      redirect_to favorite_tweets_path
    else
      redirect_to "/auth/twitter"
    end
  end

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    redirect_to '/'
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
