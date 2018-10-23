class CreateUsers < ActiveRecord::Migration[4.2]
  def self.up
    change_table :users do |t|
      t.change :crypted_password, :string
      t.change :salt, :string
      t.rename :salt, :password_salt
      
      t.string :persistence_token
      t.integer :login_count
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string :last_login_ip
      t.string :current_login_ip
      
      t.remove :remember_token, :remember_token_expires_at
    end
  end

  def self.down
    change_table :users do |t|
      t.string   :remember_token
      t.datetime :remember_token_expires_at
      
      t.remove   :current_login_ip, :last_login_ip, :current_login_at, :last_login_at
      t.remove   :last_request_at, :login_count, :persistence_token
      
      t.rename   :password_salt, :salt
      t.change   :salt, :string, :limit => 40
      t.change   :crypted_password, :string, :limit => 40
    end
  end
  
end
