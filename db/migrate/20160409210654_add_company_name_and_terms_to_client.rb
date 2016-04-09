class AddCompanyNameAndTermsToClient < ActiveRecord::Migration
  def change
    add_column :clients, :company_name, :string
    add_column :clients, :terms, :string
  end
end
