Given /^a user exists with name: "(.*?)"$/ do |name|
  FactoryBot.create(:user, name: name)
end

Given /^an admin exists with name: "(.*?)"$/ do |name|
  FactoryBot.create(:admin, name: name)
end

Given "the following users exist:" do |table|
  table.hashes.each do |attributes|
    FactoryBot.create(:user, attributes)
  end
end
