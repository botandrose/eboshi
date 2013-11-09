When /^I check all time items$/ do
  all("[type=checkbox]").each do |checkbox|
    checkbox.set true
  end
end

Given /^a time item for "(.+)"$/ do |client_name|
  @client = Client.find_by_name client_name
  @client.line_items << Work.make(:invoice => nil)
end

Then "I should see the following line items:" do |table|
  wait_for_ajax
  actual = all(".invoice tbody tr").map do |row|
    notes = row.find("textarea").value
    row = row.all("td,th").map(&:text)[1..-1]
    row[5] = notes
    row
  end
  table.diff! actual
end

Then /^I should see "(.+)" in a line item$/ do |text|
  page.should have_css(".line_item", text: text)
end

Then /^I should not see "(.+)" in a line item$/ do |text|
  page.should_not have_css(".line_item", text: text)
end

