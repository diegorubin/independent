# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'independent'
set :repo_url, 'git@github.com:diegorubin/independent.git'

set :linked_files, %w{
  config/mongoid.yml config/initializers/devise.rb config/initializers/setup_mail.rb
}

set :linked_dirs, %w{log public/uploads themes uploads}

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

  after :deploy, 'deploy:update_npm'
  after :deploy, 'deploy:restart'

end

