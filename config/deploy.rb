set :application, "pinkpong"
set :repository,  "https://github.com/joahking/pinkpong.git"

set :scm, :git
set :branch, 'master'
set :git_shallow_clone, 1
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "pinkpong.3scale.net"                          # Your HTTP server, Apache/etc
role :app, app                          # This may be the same as your `Web` server
role :db,  app, :primary => true # This is where Rails migrations will run
role :db,  app

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
