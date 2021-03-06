class FavoriteTweetsController < ApplicationController
  # FIXME: Add before_action for authentication

  def index
    @favorite_tweets_count = current_user.favorite_tweets.count
  end

  def show
    @favorite_tweet = current_user.favorite_tweets.find(params[:id])
  end

  def shuffle
    @favorite_tweet = current_user.favorite_tweets.random

    render "show"
  end

  def sync
    # Depending on if we've ever synced them before, we'll use a different method.
    if current_user.last_sync_at.present?
      SyncFavoritesJob.perform_later(current_user)
    else
      ImportFavoritesJob.perform_later(current_user)
    end

    redirect_to :favorite_tweets
  end
end
