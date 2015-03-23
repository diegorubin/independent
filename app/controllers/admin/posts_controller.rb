class Admin::PostsController < Admin::BaseController

  prepend_before_filter :prepend_view_paths, only: [:show]

  def new
    super
    @post.author = current_user.username
  end

  def show
    super
    render 'posts/show', layout: set_current_theme
  end

end

