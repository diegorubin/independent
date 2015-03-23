class Admin::PagesController < Admin::BaseController

  prepend_before_filter :prepend_view_paths, only: [:show]

  def show
    super
    render 'pages/show', layout: set_current_theme
  end

end

