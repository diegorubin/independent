class PostsController < ApplicationController

  def index
    @posts = Post.publisheds.ordered_by_published_at
  end

end

