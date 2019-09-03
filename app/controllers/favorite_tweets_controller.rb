class FavoriteTweetsController < ApplicationController
  def sync
    ImportFavoritesJob.perform_now(current_user)
    render plain: "Performed sync!"
  end
end
