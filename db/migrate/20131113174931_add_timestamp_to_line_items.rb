class AddTimestampToLineItems < ActiveRecord::Migration[4.2]
  def change
    add_column :line_items, :timestamp, :integer, limit: 8, default: 0
  end
end
