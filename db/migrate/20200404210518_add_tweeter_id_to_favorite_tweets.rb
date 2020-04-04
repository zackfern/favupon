class AddTweeterIdToFavoriteTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :favorite_tweets, :tweeter_id, :string
    add_index :favorite_tweets, :tweeter_id
  end
end
