class RenameLoginToName < ActiveRecord::Migration[4.2]
  def self.up
    rename_column :users, :login, :name
  end

  def self.down
    rename_column :users, :name, :login
  end
end
