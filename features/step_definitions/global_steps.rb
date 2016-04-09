Then /^I should not be able to go to (.+)$/ do |url|
  visit url
  page.status_code.should == 403
end

Given /^I am signed in as "Micah"$/ do
  step 'a user exists with name: "Micah"'
  @user = User.find_by_name "Micah"
  login_user(@user)
end

Given /^I am signed in as an Admin$/ do
  step 'an admin exists with name: "Admin"'
  @user = User.find_by_name "Admin"
  login_user(@user)
end

Given /^I worked (\d+) hours for "([^\"]*)" on "([^\"]*)"$/ do |hours, client_name, date|
  date = Time.zone.parse(date)
  client = Client.find_by_name(client_name)
  FactoryGirl.create(:work, client: client, start: date, finish: date + hours.to_f.hours, user: @user)
end

Given /^I worked (\d+) hours for "([^\"]*)" today$/ do |hours, client_name|
  client = Client.find_by_name(client_name)
  start = Time.zone.today + 1.hour
  finish = start + hours.to_f.hours
  FactoryGirl.create(:work, client: client, start: start, finish: finish, user: @user)
end

def login_user user
  visit "/"
  fill_in "Email", with: user.email
  fill_in "Password", with: "secret"
  click_button "Login"
  page.should have_content("Welcome, #{user.name}!")
end
