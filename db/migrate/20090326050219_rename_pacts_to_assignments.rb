class RenamePactsToAssignments < ActiveRecord::Migration[4.2]
  def self.up
    rename_table :pacts, :assignments
  end

  def self.down
    rename_table :assignments, :pacts
  end
end
