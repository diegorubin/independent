class PostsController < ApplicationController

  layout :set_current_theme

  def index
    @posts = Post.publisheds.ordered_by_published_at
  end

end

