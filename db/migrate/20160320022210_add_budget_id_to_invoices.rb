class AddBudgetIdToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :budget_id, :integer
  end
end
