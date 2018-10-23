class AddTimestampsToInvoices < ActiveRecord::Migration[4.2]
  def change
    change_table :invoices do |t|
      t.timestamps
    end
  end
end

