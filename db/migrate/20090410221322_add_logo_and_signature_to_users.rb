class AddLogoAndSignatureToUsers < ActiveRecord::Migration[4.2]
  def self.up
    add_column :users, :logo_file_name,    :string
    add_column :users, :logo_content_type, :string
    add_column :users, :logo_file_size,    :integer
    add_column :users, :logo_updated_at,   :datetime

    add_column :users, :signature_file_name,    :string
    add_column :users, :signature_content_type, :string
    add_column :users, :signature_file_size,    :integer
    add_column :users, :signature_updated_at,   :datetime
  end

  def self.down
    remove_column :users, :signature_file_name
    remove_column :users, :signature_content_type
    remove_column :users, :signature_file_size
    remove_column :users, :signature_updated_at

    remove_column :users, :logo_file_name
    remove_column :users, :logo_content_type
    remove_column :users, :logo_file_size
    remove_column :users, :logo_updated_at
  end
end
