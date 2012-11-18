#ruby=ree-1.8.7-2011.03
#ruby-gemset=eboshi
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
gem "default_value_for"
gem "dynamic_form"

gem "sprockets-image_compressor"
gem "sass-rails"
gem "compass-rails"
gem "coffee-rails"
gem "therubyracer"
gem "uglifier"

gem "jquery-rails"
gem "jquery-ui-rails"

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
  gem "poltergeist"
  gem "pickle"
end

group :production do
  gem "exception_notification"
  gem "whenever", :require => false
end
