require 'machinist/active_record'
require 'sham'
require 'faker'

Client.blueprint do
  name { Faker::Company.name }
  address { Faker::Address.street_address }
  city { Faker::Address.city }
  state { Faker::Address.state }
  zip { Faker::Address.zip_code }
  country { Faker::Address.country }
  email { Faker::Internet.email }
  contact { Faker::Name.name }
  phone { Faker::PhoneNumber.phone_number }  
end

User.blueprint do
  name { Faker::Name.name.gsub(/[^a-zA-Z]/, '') }
  email { Faker::Internet.email }
  password "secret"
  password_confirmation "secret"
  created_at { Time.now }
  updated_at { Time.now }
  rate 50
  color '123456'
end

Work.blueprint do
  client
  invoice
  user
  start { Time.now }
  finish { Time.now + 1.hour }
  rate 50
  notes { Faker::Lorem.sentence rand(3) }
end

Work.blueprint(:unbilled) do
  invoice { nil }
end

Adjustment.blueprint do
  client
  invoice
  rate 0
  notes "adjustment"
end

Invoice.blueprint do
  client
  date { Time.zone.now }
  project_name { Faker::Company.name }
end

Payment.blueprint do
  invoice
  total 0
end
