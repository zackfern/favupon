class CreateFavoriteTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_tweets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :twitter_id
      t.integer :favorite_count
      t.integer :retweet_count
      t.datetime :favorited_at
      t.datetime :tweeted_at

      t.timestamps
    end
  end
end
