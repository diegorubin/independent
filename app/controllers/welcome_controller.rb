class WelcomeController < ApplicationController

  layout :set_current_theme
  
  prepend_before_filter :prepend_view_paths

  def index
  end

end

