class AddLastSyncAtToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :last_sync_at, :datetime
  end
end
