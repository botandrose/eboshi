class AddInvoiceDetailsToUser < ActiveRecord::Migration[4.2]
  def self.up
    add_column :users, :business_name, :string
    add_column :users, :business_email, :string
    add_column :users, :address, :string
    add_column :users, :address2, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :string
  end

  def self.down
    remove_column :users, :zip
    remove_column :users, :state
    remove_column :users, :city
    remove_column :users, :address2
    remove_column :users, :address
    remove_column :users, :business_email
    remove_column :users, :business_name
  end
end
