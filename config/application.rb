require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Independent
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Brasilia'

    config.autoload_paths += %W{
      #{Rails.root}/lib/behaviours
    }

    config.i18n.default_locale = 'pt-BR'

    config.enconding = 'utf-8'

    config.filter_parameters += [:password, :password_confirmation]

    # Devise
    config.to_prepare do
      Devise::SessionsController.layout "login"
      Devise::PasswordsController.layout "login"
    end

    # themes path
    [:fonts, :images, :javascripts, :stylesheets].each do |d|
      config.assets.paths << "#{Rails.root}/themes/#{d}"
    end

  end
end

