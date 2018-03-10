class PostsController < SiteController

  def index
    posts = Post.publisheds
    posts = posts.filter_by_domain(current_domain) if is_multiple_domains_enabled?
    @posts = posts.ordered_by_published_at.
      filters(params).page(params.fetch(:page, 1))
  end

  def show
    @post = Post.find_by_slug(params[:date], params[:slug]).first
    respond_to do |format|
      format.html {}
      format.json do
        @post.body = @post.body.from_markdown_to_html
        render json: @post.to_json
      end
    end
  end

end

