require 'bundler/capistrano'

set :application, "pinkpong"
set :domain, "pinkpong.pent.es"

set :repository,  "https://github.com/joahking/pinkpong.git"
set :scm, :git
set :branch, 'deploy'
set :git_shallow_clone, 1
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :use_sudo, false
set :user, 'deploy'
set :deploy_to, "/home/deploy/#{application}"

set :shared_dirs, ['config', 'tmp', 'public/system']

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
role :db,  domain

after "deploy:update_code", "update_code"

desc "Make symlink for app yaml"
task :update_code do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
