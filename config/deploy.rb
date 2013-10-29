set :application, "eboshi"
set :rvm_ruby_string, "ruby-2.0.0-p195@eboshi"
set :asset_paths, ["public/logos", "public/signatures"]
role :production, "www@eboshi.botandrose.com:22022"

desc "Update the crontab file"
task :update_crontab, :roles => :production do
  run "cd #{application} && bundle exec whenever --update-crontab #{application}"
end

after "deploy", "update_crontab"

