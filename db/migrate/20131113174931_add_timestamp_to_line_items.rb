class AddTimestampToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :timestamp, :integer, limit: 8, default: 0
  end
end
