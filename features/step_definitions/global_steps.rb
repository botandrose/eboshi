Then /^I should not be able to go to (.+)$/ do |url|
  visit url
  expect(page.text).to be_empty
end

Given /^I am signed in as "Micah"$/ do
  step 'a user exists with name: "Micah"'
  @user = User.find_by_name "Micah"
  visit "/"
  fill_in "Email", with: @user.email
  fill_in "Password", with: "secret"
  click_button "Login"
  step 'I should see "Welcome, Micah!"'
end

Given /^I am signed in as an Admin$/ do
  step 'an admin exists with name: "Admin"'
  @user = User.find_by_name "Admin"
  visit "/"
  fill_in "Email", with: @user.email
  fill_in "Password", with: "secret"
  click_button "Login"
  step 'I should see "Welcome, Admin!"'
end

Given /^I worked (\d+) hours for "([^\"]*)" on "([^\"]*)"$/ do |hours, client_name, date|
  date = Time.zone.parse(date)
  client = Client.find_by_name(client_name)
  FactoryBot.create(:work, client: client, start: date, finish: date + hours.to_f.hours, user: @user)
end

Given /^I worked (\d+) hours for "([^\"]*)" today$/ do |hours, client_name|
  client = Client.find_by_name(client_name)
  start = Time.zone.today + 1.hour
  finish = start + hours.to_f.hours
  FactoryBot.create(:work, client: client, start: start, finish: finish, user: @user)
end
