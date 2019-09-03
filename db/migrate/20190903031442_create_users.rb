class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :twitter_uid
      t.string :access_token
      t.string :access_secret

      t.timestamps
    end
  end
end
