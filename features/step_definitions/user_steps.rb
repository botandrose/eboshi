Given /^a user exists with name: "(.*?)"$/ do |name|
  FactoryGirl.create(:user, name: name)
end

Given /^an admin exists with name: "(.*?)"$/ do |name|
  FactoryGirl.create(:admin, name: name)
end

Given "the following users exist:" do |table|
  table.hashes.each do |attributes|
    FactoryGirl.create(:user, attributes)
  end
end

