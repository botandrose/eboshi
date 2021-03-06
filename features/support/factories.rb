require "faker"
require "factory_bot"

FactoryBot.define do
  factory :client do
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

  factory :user do
    name { Faker::Name.name.gsub(/[^a-zA-Z]/, '') }
    email { Faker::Internet.email }
    password { "secret" }
    password_confirmation { "secret" }
    created_at { Time.now }
    updated_at { Time.now }
    rate { 50 }
    color { '123456' }

    factory :admin do
      admin { true }
    end
  end

  factory :work do
    client
    invoice
    user
    start { Time.now }
    finish { start + 1.hour }
    rate { 50 }
    notes { Faker::Lorem.sentence(word_count: rand(3)) }
  end

  factory :adjustment do
    client
    invoice
    rate { 0 }
    notes { "adjustment" }
  end

  factory :invoice do
    client
    date { Time.zone.now }
    project_name { Faker::Company.name }
  end

  factory :payment do
    invoice
    total { 0 }
  end
end
