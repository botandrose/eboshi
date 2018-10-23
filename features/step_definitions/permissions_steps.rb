Then /^visiting the invoices page for "(.+)" should return 404$/ do |name|
  client = Client.find_by_name name
  visit "/clients/#{client.id}/invoices"
  expect(page).to have_content("RecordNotFound")
end

Then /^visiting that (\w+) (\w*)[ ]?page should return 404$/ do |model_name, action|
  model = model_name.tr(' ', '_').classify.constantize
  args = [model.first]
  args.unshift action.to_sym unless action.blank?
  visit polymorphic_path(args)
  expect(page).to have_content("RecordNotFound")
end

Then /^visiting the new payment page for that invoice should return 404$/ do
  invoice = Invoice.first
  visit new_payment_path(invoice)
  expect(page).to have_content("RecordNotFound")
end
