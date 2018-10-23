class AddIndexesForForeignKeys < ActiveRecord::Migration[4.2]
  def self.up
    add_index 'payments', 'invoice_id'
    add_index 'assignments', 'user_id'
    add_index 'assignments', 'client_id'
    add_index 'users', 'last_client_id'
    add_index 'line_items', 'client_id'
    add_index 'line_items', 'user_id'
    add_index 'line_items', 'invoice_id'
    add_index 'invoices', 'client_id'
  end

  def self.down
    remove_index 'payments', 'invoice_id'
    remove_index 'assignments', 'user_id'
    remove_index 'assignments', 'client_id'
    remove_index 'users', 'last_client_id'
    remove_index 'line_items', 'client_id'
    remove_index 'line_items', 'user_id'
    remove_index 'line_items', 'invoice_id'
    remove_index 'invoices', 'client_id'
  end
end
