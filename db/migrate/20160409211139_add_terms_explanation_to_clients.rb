class AddTermsExplanationToClients < ActiveRecord::Migration
  def change
    add_column :clients, :terms_explanation, :text
  end
end
