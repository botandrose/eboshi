class AddShowSummariesToUsers < ActiveRecord::Migration[4.2]
  def self.up
    add_column :users, :show_summaries, :boolean, :default => true
  end

  def self.down
    remove_column :users, :show_summaries
  end
end
