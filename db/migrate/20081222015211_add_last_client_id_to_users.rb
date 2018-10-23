class AddLastClientIdToUsers < ActiveRecord::Migration[4.2]
  def self.up
    add_column :users, :last_client_id, :integer
  end

  def self.down
    remove_column :users, :last_client_id
  end
end
