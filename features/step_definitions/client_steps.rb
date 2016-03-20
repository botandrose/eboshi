Given /^a client exists with name: "(.*?)"$/ do |name|
  FactoryGirl.create(:client, name: name)
end

Given "the following clients exist:" do |table|
  table.hashes.each do |attributes|
    FactoryGirl.create(:client, attributes)
  end
end
