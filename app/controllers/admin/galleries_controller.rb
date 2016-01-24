class Admin::GalleriesController < Admin::BaseController

  prepend_before_filter :prepend_view_paths, only: [:show]

  def new
    super
    @gallery.author = current_user.username
  end

  def show
    super
    render 'galleries/show', layout: set_current_theme
  end

end

