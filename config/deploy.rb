require "bundler/capistrano"
require "capistrano_colors"
# load 'deploy/assets'

set :application, "carddav"
set :deploy_to, "/home/carddav/app"

set :scm, :git
set :repository,  "git://github.com/nonfiction/meishi.git"

default_run_options[:pty] = true
set :use_sudo, false
set :user, "carddav"
set :password, ""

set :domain , lambda { domain = Capistrano::CLI.ui.ask "Enter the server location:" }

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do

  before 'deploy:create_symlink' do
    run "cp #{shared_path}/config/00_first_initializer.rb #{release_path}/config/initializers/00_first_initializer.rb"
  end
  
  task :restart do
    run "touch #{current_path}/tmp/restart.txt" 
  end
end