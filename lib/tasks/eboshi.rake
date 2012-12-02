namespace :eboshi do
  desc "Initial setup after install"
  task :bootstrap => ["db:create", "db:schema:load"]
end
