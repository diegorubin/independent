class ApplicationController < ActionController::Base
  include SettingsHelper

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #rescue_from ActionController::RoutingError, :with => :render_not_found
  #rescue_from ActionController::UnknownController, :with => :render_not_found
  
  rescue_from RecordNotFound, :with => :render_not_found

  protected
  def set_current_theme
    theme = current_theme
    if theme.blank? || theme == 'default'
      'application'
    else
      "/themes/layouts/#{theme}"
    end
  end

   def prepend_view_paths
     theme = current_theme
     if !theme.blank? && theme != 'default'
       prepend_view_path(Rails.root.join("themes/views/#{theme}"))
     end
   end

  def render_not_found
    render :template => 'error_pages/404', :status => :not_found
  end

  def klass
    controller_name.classify.constantize
  end

end

