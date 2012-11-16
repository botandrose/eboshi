source "http://rubygems.org"

gem "rails"
gem "haml-rails"
gem "mysql2"
gem "bard-rake"
gem "authlogic"
gem "paperclip", "~>2.7"
gem "RedCloth"
gem "ratom", :require => "atom"
gem "chronic"

gem "sprockets-image_compressor"
gem "sass-rails"
gem "compass-rails"
gem "coffee-rails"
gem "therubyracer"
gem "uglifier"

group :test, :development do
  gem "pry"
  gem "ruby-debug"
  gem "quiet_assets"

  gem "rspec-rails"
end

group :test do
  gem "machinist", "~>1.0"
  gem "faker"
  gem "delorean"

  gem "cucumber-rails", :require => false
  gem "database_cleaner"
  gem "capybara"
  gem "pickle"
end

group :production do
  gem "exception_notification"
  gem "whenever", :require => false
end
