require "bundler/capistrano"
require "capistrano_colors"

set :application, "carddav"
set :deploy_to, "/home/carddav/app"

set :scm, :git
set :repository,  "git@github.com:nonfiction/meishi.git"

default_run_options[:pty] = true
set :use_sudo, false
set :user, "carddav"
set :password, ""

set :domain , lambda { domain = Capistrano::CLI.ui.ask "Enter the server location:" }
set :normalize_asset_timestamps, false

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt" 
  end
end