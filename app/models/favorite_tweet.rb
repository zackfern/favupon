class FavoriteTweet < ApplicationRecord
  belongs_to :user

  validates :twitter_id, presence: true, uniqueness: { scope: :user_id }

  scope :random, -> { order(Arel.sql('RANDOM()')).first }

  class << self
    # Helper class method to find or create objects based off of a User and Tweet
    def create_for_user_from_tweet(user:, tweet:)
      user.favorite_tweets.find_or_create_by(twitter_id: tweet.id) do |record|
        record.favorite_count = tweet.favorite_count
        record.retweet_count = tweet.retweet_count
        record.tweeted_at = tweet.created_at
        record.tweeter_id = tweet.user.id
      end
    end
  end
end
