class WelcomeController < ApplicationController

  layout :set_current_theme
  
  prepend_before_filter :prepend_view_paths

  def index
    @search = params.fetch(:s, '').split.join('|')
    @list_items = ListItem.filters(params).ordered_by_published_at.
      page(params.fetch(:page, 1))
  end

end

