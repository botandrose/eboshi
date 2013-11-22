class AddTimestampsToInvoices < ActiveRecord::Migration
  def change
    change_table :invoices do |t|
      t.timestamps
    end
  end
end

