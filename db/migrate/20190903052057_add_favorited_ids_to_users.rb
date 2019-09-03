class AddFavoritedIdsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :max_favorited_id, :string
    add_column :users, :min_favorited_id, :string
  end
end
