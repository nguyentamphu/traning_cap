# config valid only for current version of Capistrano
lock "3.9.1"

set :application, 'traning_cap' # Ten thu muc app
set :repo_url, 'git@github.com:nguyentamphu/traning_cap.git' # url repo
set :deploy_to, '/var/www/traning_cap' # Thu muc chua app tren server
set :deploy_user, 'root' # user deploy tren server
set :branch, 'develop' # branch de deploy
set :stages, %w(production) # moi truong deploy
set :default_stage, 'production' # default moi truong deploy

set :linked_files,
    fetch(:linked_files, [])
    .push('config/database.yml', 'config/secrets.yml', 'config/unicorn.rb')

set :linked_dirs,
    fetch(:linked_dirs, [])
    .push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle',
          'public/system')

# Default value for keep_releases is 5
set :keep_releases, 5

# Custom tasks
namespace :deploy do
  desc 'Invoke a rake command'
  task :invoke, [:command] => 'deploy:set_rails_env' do |task, args|
    on primary(:app) do
      within current_path do
        with :rails_env => fetch(:rails_env) do
          rake args[:command]
        end
      end
    end
  end
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
