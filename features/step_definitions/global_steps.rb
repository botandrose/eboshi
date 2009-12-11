Then /^I should not be able to go to (.+)$/ do |url|
  visit url
  response.code.should == "403"
end

Given /^I am signed in as "Micah"$/ do
  @user = User.make :name => "Micah", :password => "insecure", :password_confirmation => "insecure"
  visit "/"
  fill_in "email", :with => @user.email
  fill_in "password", :with => "insecure"
  click_button "Login"
  response.should contain "Welcome,"
  response.should contain "Micah!"
end

Given /^I am signed in as an Admin$/ do
  @user = User.make :name => "Admin", :password => "insecure", :password_confirmation => "insecure", :admin => true
  visit "/"
  fill_in "email", :with => @user.email
  fill_in "password", :with => "insecure"
  click_button "Login"
  response.should contain "Welcome,"
  response.should contain "Admin!"
end

Given /^the following (.+) exist:$/ do |model, table|
  model = model.singularize.capitalize.constantize
  table.hashes.each do |row|
    model.make row
  end
end

Given /^there is a client named "([^\"]*)"$/ do |name|
  Client.make :name => name
end

Given /^today is "([^\"]*)"$/ do |date|
  Date.stub!(:today).and_return(Date.parse(date))
end

Given /^I worked (\d+) hours for "([^\"]*)" today$/ do |hours, client_name|
  client = Client.find_by_name(client_name)
  client.works.make :start => Date.today, :finish => Date.today + hours.to_f.hours, :user => @user
end

