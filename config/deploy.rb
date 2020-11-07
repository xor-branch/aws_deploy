# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

# Application name to deploy
set :application, 'bishop'
# git repository to clone
# (Xxxxxxxx: user name, yyyyyyyy: application name)
set :repo_url, 'https://github.com/Baroka-wp/blogtest.git'
# The branch to deploy. The default is not necessarily master.
set :branch, ENV['BRANCH'] || 'master'
# The directory to deploy to.
set :deploy_to, 'home/deploy/bishop'
# Folders/files with symbolic links
set :linked_files, %w{config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/uploads}
set :keep_releases, 5
# Ruby version
set :rbenv_ruby, '2.6.5'
set :rbenv_type, :system
# The level of the log to output. If you want to see the error log in detail : debug Set to.
# If it is for production environment : info is normal.
# However, if you want to check the behavior firmly : debug Set to.
set :log_level, :info
namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end
  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end
  after :publishing, :restart
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
