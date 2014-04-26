class PostsController < ApplicationController

  def show
    @post = Post.find_by_slug(params[:date], params[:slug]).first
    raise PostNotFound if @post.nil?

    @comments = @post.comments
  end

  def index
    unless params[:date]
      @posts = Post.where(:published => true).
                    ordered_by_published_at.
                    page(params.fetch(:page,1)) 
    else
      @posts = Post.where(:published => true,
                    :date => /#{params[:date]}/).
                    ordered_by_published_at.
                    page(params.fetch(:page,1)) 
    end
  end

  def search
  end

end
