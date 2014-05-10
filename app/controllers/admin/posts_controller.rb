class Admin::PostsController < Admin::BaseController

  def new
    super
    @post.author = current_user.username
  end

end

