class AddBudgetIdToInvoices < ActiveRecord::Migration[4.2]
  def change
    add_column :invoices, :budget_id, :integer
  end
end
