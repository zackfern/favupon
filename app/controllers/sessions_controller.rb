class SessionsController < ApplicationController
  def index
    if logged_in?
      render plain: "Logged in!"
    else
      redirect_to :new
    end
  end

  def new
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
