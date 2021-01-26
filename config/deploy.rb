# config valid for current version and patch releases of Capistrano
lock "~> 3.15.0"

set :application, "reservas"
#set :repo_url, "git@example.com:me/my_repo.git"
set :repo_url, "git@github.com:Thais2211/reservas.git"
#set :repo_url, 'https://thais2211:Rebecca1810@github.com/Thais2211/reservas.git'

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/meriva.td.utfpr.edu.br"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
#set :linked_files, %w{config/database.yml}
append :linked_files, "config/database.yml", "config/storage.yml", "config/master.key"

# Default value for linked_dirs is []
#set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
append :linked_dirs, "bin", "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
 
  namespace :deploy do
  
    desc 'Restart application'
    task :restart do
      on roles(:app), in: :sequence, wait: 5 do
        execute "sudo /etc/init.d/nginx restart"
      end
    end
  
    after :publishing, 'deploy:restart'
    after :finishing, 'deploy:cleanup'
  end

