class ApplicationController < ActionController::Base
  include SettingsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def set_current_theme
    theme = current_theme
    if theme.blank? || theme == 'default'
      'application'
    else
      "/themes/layouts/#{theme}"
    end
  end

end

