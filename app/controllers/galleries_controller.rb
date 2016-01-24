class GalleriesController < ApplicationController

  layout :set_current_theme
  prepend_before_filter :prepend_view_paths

  def show
    @gallery = Gallery.find_by_slug(params[:date], params[:slug]).first
  end

end

