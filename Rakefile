#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Eboshi::Application.load_tasks

require 'coveralls/rake/task'
Coveralls::RakeTask.new

task :ci => ["coveralls:push"]

task :update_crontab do
  system "bundle exec whenever --update-crontab complexity"
end

task "bootstrap:production:post" => [:update_crontab, "tmp:clear"]

