class SyncFavoritesJob < ApplicationJob
  queue_as :default

  attr_accessor :client, :user, :max_favorited_id

  def perform(user)
    @user = user
    @client = @user.twitter_client

    # Set the minimum tweet ID we're looking for to the largest ID we have in our DB.
    @max_favorited_id = @user.max_favorited_id

    @user.update_attribute(:last_sync_at, Time.now)

    recursively_fetch_and_save_favorites
  end

  def recursively_fetch_and_save_favorites
    opts = { count: 200 }
    Rails.logger.debug "max_favorited_id -> #{max_favorited_id}"
    opts[:since_id] = max_favorited_id

    # Find favorites that are older than our minimum favorited ID.
    favorites = client.favorites(opts)
    favorites.each do |fav|
      FavoriteTweet.create_for_user_from_tweet(user: user, tweet: fav)
    end

    # Update the maximum favorited ID.
    @max_favorited_id = favorites.collect(&:id).max
    user.update_attribute(:max_favorited_id, @max_favorited_id) unless @max_favorited_id.nil?

    # If the # of favorites returned was > 199, call again so we can keep paginating...
    if favorites.count > 199
      # Recursively call this method to do it again.
      recursively_fetch_and_save_favorites
    end
  end
end
