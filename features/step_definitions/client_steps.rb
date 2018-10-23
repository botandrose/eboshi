Given /^a client exists with name: "(.*?)"$/ do |name|
  FactoryBot.create(:client, name: name)
end

Given "the following clients exist:" do |table|
  table.hashes.each do |attributes|
    FactoryBot.create(:client, attributes)
  end
end
