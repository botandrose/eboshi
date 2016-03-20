class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.references :client
      t.string :name
      t.decimal :total, precision: 10, scale: 2
      t.timestamps
    end
  end
end
