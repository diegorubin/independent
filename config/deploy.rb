# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'independent'
set :repo_url, 'git@github.com:diegorubin/independent.git'

set :linked_files, %w{
  config/mongoid.yml config/initializers/devise.rb config/initializers/setup_mail.rb
}

set :linked_dirs, %w{log public/uploads themes}

namespace :deploy do

  #desc 'Restart application'
  #task :restart do
  #  on roles(:app), in: :sequence, wait: 5 do
  #    execute :touch, release_path.join('tmp/restart.txt')
  #  end
  #end

  before :deploy, 'deploy:compile_assets'
  after :deploy, 'deploy:restart'

end

