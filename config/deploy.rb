# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'independent'
set :repo_url, 'git@github.com:diegorubin/independent.git'

set :linked_files, %w{config/mongoid.yml}

set :linked_dirs, %w{uploads}

namespace :deploy do

  desc 'Copy config files'
  task :configure do
    on roles(:app) do
      execute :cp, "#{deploy_to}/shared/config/mongoid.yml", release_path.join('config')
      execute :cp, "#{deploy_to}/shared/config/{devise.rb,setup_mail.rb}", release_path.join('config/initializers')

      # remove versioned themes
      execute :rm, '-rf', release_path.join('themes')
      execute :ln, '-s', "#{deploy_to}/shared/themes", release_path.join('themes')
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :deploy, 'deploy:compile_assets'
  after :deploy, 'deploy:cleanup'

end

