class FavoriteTweet < ApplicationRecord
  belongs_to :user

  validates :twitter_id, presence: true, uniqueness: { scope: :user_id }
end
