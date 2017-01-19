class PostsController < SiteController

  def index
    @posts = Post.publisheds.ordered_by_published_at.
      filters(params).page(params.fetch(:page, 1))
  end

  def show
    @post = Post.find_by_slug(params[:date], params[:slug]).first
  end

end

