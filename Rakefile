#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Eboshi::Application.load_tasks

require 'coveralls/rake/task'
Coveralls::RakeTask.new

task :ci => ["coveralls:push"]

task :restart do
  if ENV["RAILS_ENV"] == "production"
    Rake::Task["tmp:clear"].invoke
  end
end

