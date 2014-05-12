class PagesController < ApplicationController

  layout :set_current_theme

  prepend_before_filter :prepend_view_paths

  def show
    @page = Page.publisheds.find_by_simple_slug(params[:slug]).first
  end

end

