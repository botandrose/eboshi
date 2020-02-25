source "http://rubygems.org"

gem "rails", "~>5.2.0"
gem "bootsnap"
gem "mysql2"
gem "bard-rake", "~>0.16.0" # 0.17 requires rails 6+
gem "bard-static"
gem "haml-rails"
gem "authlogic", "~>4.0" # need to sort out validations to upgrade to 5.0
gem "paperclip"
gem "default_value_for"
gem "dynamic_form"
gem "wicked_pdf"

gem "sprockets", "~>3.0"

gem "sass-rails"
gem "compass-rails"

gem "coffee-rails"
gem "uglifier"
gem "jquery-rails"

group :development do
  gem "bard"
  gem "web-console"
end

group :development, :test do
  gem "byebug"
  gem "parallel_tests"
end

group :test do
  gem "cucumber-rails", require: false
  gem "capybara-headless_chrome"
  gem "capybara-screenshot"
  gem "factory_bot_rails"
  gem "database_cleaner"
  gem "faker"
  gem "delorean"
  gem "rspec-rails"
  gem "rails-controller-testing"
end
gem "coveralls", require: false

group :production do
  gem "exception_notification"
end

