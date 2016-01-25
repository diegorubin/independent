# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'independent'
set :repo_url, 'git@github.com:diegorubin/independent.git'

set :linked_files, %w{
  config/application.yml config/mongoid.yml config/initializers/devise.rb 
  config/initializers/setup_mail.rb config/newrelic.yml
  config/environments/production.rb config/unicorn.rb
  config/secrets.yml
}

set :linked_dirs, %w{pids log public/uploads themes uploads node_modules}

set :unicorn_pid, -> { "#{shared_path}/pids/unicorn.pid" }
set :unicorn_config_path, -> { "#{shared_path}/config/unicorn.rb" }

namespace :delayed_job do

  desc 'stop delayed job'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      if Dir.exists?(release_path)
        execute "cd '#{release_path}';RAILS_ENV=production bin/delayed_job stop"
      end
    end
  end

  desc 'start delayed job'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd '#{release_path}';RAILS_ENV=production bin/delayed_job start"
    end
  end

end

namespace :deploy do

  desc 'Restart application'
  namespace :deploy do
    task :restart do
      invoke 'unicorn:reload'
    end
  end

  desc 'update npm'
  task :update_npm do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd '#{release_path}'; npm install"
    end
  end

  desc 'stop preview server'
  task :stop_preview_server do
    on roles(:app), in: :sequence, wait: 5 do
      forever_service('stop')
    end
  end

  desc 'start preview server'
  task :start_preview_server do
    on roles(:app), in: :sequence, wait: 5 do
      forever_service('start')
    end
  end

  before :deploy, 'deploy:stop_preview_server'
  before :deploy, 'delayed_job:stop'

  after :deploy, 'deploy:update_npm'
  after :deploy, 'delayed_job:start'
  after :deploy, 'deploy:start_preview_server'

  after 'deploy:publishing', 'deploy:restart'

end

def forever_service(command)
  begin
    forever_cmd = File.join(shared_path, 'node_modules/.bin/forever')
    execute "cd '#{release_path}'; #{forever_cmd} #{command} lib/node/preview/server.js -p #{current_path}"
  rescue
    warn "preview server not started"
  end
end

