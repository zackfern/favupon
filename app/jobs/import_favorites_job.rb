class ImportFavoritesJob < ApplicationJob
  queue_as :default

  attr_accessor :client, :user, :min_favorited_id

  def perform(user)
    @user = user
    @client = @user.twitter_client
    @min_favorited_id = @user.min_favorited_id

    @user.update_attribute(:last_sync_at, Time.now)

    recursively_fetch_and_save_favorites
  end

  def recursively_fetch_and_save_favorites
    # Construct default options of count 200, but only specify a Max ID if not nil.
    opts = { count: 200 }
    opts[:max_id] = min_favorited_id if min_favorited_id

    # Find favorites that are older than our minimum favorited ID.
    favorites = client.favorites(opts)

    # Loop over 'em and save to the database...
    favorites.each do |fav|
      FavoriteTweet.create_for_user_from_tweet(user: user, tweet: fav)
    end

    # Update the minimum favorited ID.
    @min_favorited_id = favorites.collect(&:id).min
    updated = user.update_attribute(:min_favorited_id, @min_favorited_id)

    # If the # of favorites returned was > 199, call again so we can keep paginating...
    if favorites.count > 199
      # Recursively call this method to do it again.
      recursively_fetch_and_save_favorites
    end
  end
end
