class WelcomeController < ApplicationController

  layout :set_current_theme
  
  prepend_before_filter :prepend_view_paths

  def index
    @list_items = ListItem.filters(params).page(params.fetch(:page, 1))
  end

end

