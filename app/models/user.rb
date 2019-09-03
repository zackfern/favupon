class User < ApplicationRecord
  has_many :favorite_tweets

  class << self
    # Public: Find or create a User record based off of the Omniauth auth hash.
    # Returns User
    def find_or_create_from_auth_hash(auth_hash)
      self.find_or_create_by(twitter_uid: auth_hash[:uid], access_token: auth_hash[:credentials][:token]) do |user|
        user.access_secret = auth_hash[:credentials][:secret]
      end
    end
  end

  def twitter_client
    @twitter_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.access_token = access_token
      config.access_token_secret = access_secret
    end
  end
end
