# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'independent'
set :repo_url, 'git@github.com:diegorubin/independent.git'

set :linked_files, %w{
  config/application.yml config/mongoid.yml config/initializers/devise.rb 
  config/initializers/setup_mail.rb
}

set :linked_dirs, %w{log public/uploads themes uploads node_modules}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
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

  after :deploy, 'deploy:update_npm'
  after :deploy, 'deploy:restart'
  after :deploy, 'deploy:start_preview_server'

end

def forever_service(command)
  begin
    forever_cmd = File.join(shared_path, 'node_modules/.bin/forever')
    execute "cd '#{release_path}'; #{forever_cmd} #{command} lib/node/preview/server.js -p #{current_path}"
  rescue
    warn "preview server not started"
  end
end

