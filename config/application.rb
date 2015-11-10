require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Independent
  class Application < Rails::Application
    config.time_zone = 'Brasilia'

    config.autoload_paths += %W{
      #{Rails.root}/themes/lib #{Rails.root}/lib/admin_form
      #{Rails.root}/lib/spellchecker
    }

    I18n.enforce_available_locales = false
    config.i18n.available_locales = ["pt-BR"]
    config.i18n.default_locale = :'pt-BR'
    config.i18n.locale = :'pt-BR'

    config.enconding = 'utf-8'

    config.filter_parameters += [:password, :password_confirmation]

    # Devise
    config.to_prepare do
      Devise::SessionsController.layout "login"
      Devise::PasswordsController.layout "login"
    end

    # Mongoid
    Moped.logger = Logger.new(StringIO.new)
    Mongoid.logger = Logger.new(StringIO.new)

    # themes path
    [:fonts, :images, :javascripts, :stylesheets].each do |d|
      config.assets.paths << "#{Rails.root}/themes/#{d}"
    end
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
    config.assets.precompile << /\.(?:png|jpg|jpeg|gif)\z/


  end
end

