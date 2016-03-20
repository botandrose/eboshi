Then /^I should see dates on the invoice$/ do
  page.body.should match /\d{2}\/\d{2}\/\d{2}/
end

Then /^I should not see any dates on the invoice$/ do
  page.body.should_not match /\d{2}\/\d{2}\/\d{2}/
end

Then /^I should see times on the invoice$/ do
  page.should have_xpath('//*', text: /\d{1,2}:\d{2}.[ap]m/i)
end

Then /^I should not see any times on the invoice$/ do
  page.should have_no_xpath('//*', text: /\d{1,2}:\d{2}.[ap]m/i)
end

When /^I edit the first invoice for "([^\"]*)"$/ do |name|
  client = Client.find_by_name name
  visit edit_invoice_path(client.invoices.first)
end

When /^I uncheck the first line item$/ do
  all("input[type=checkbox]")[0].set false
end

Then /^I should see ([a-z]+) line items?$/ do |number|
  number = english_to_number number
  all(".line_item").length.should == number
end

Then "I should see the following invoice breakdown:" do |table|
  actual = all("tr.breakdown").map do |row|
    text = row.all("td,th").map(&:text)
    [text[1], text[3], text[5]]
  end
  table.diff! actual
end
