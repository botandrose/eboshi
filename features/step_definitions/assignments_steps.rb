Given /^the user "(.+)" has the following assignments:$/ do |name, table|
  user = User.find_by_name name
  table.hashes.each do |row|
    user.clients << Client.find_by_name(row[:client])
  end
end

Given /^the client "(.+)" has the following assignments:$/ do |name, table|
  client = Client.find_by_name name
  table.hashes.each do |row|
    client.users << User.find_by_name(row[:user])
  end
end

Given /^the user "([^\"]*)" is assigned to "([^\"]*)"$/ do |user_name, client_name|
  user = User.find_by_name user_name
  client = Client.find_by_name client_name
  user.clients << client
end

Given /^a[n]? (.+) exists for "(.+)"$/ do |model_name, name|
  client = Client.find_by_name name
  client.send(model_name.tr(' ', '_').pluralize.to_sym) << FactoryGirl.create(model_name)
end
