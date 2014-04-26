class Admin::PostsController < AdminController

  before_filter :get_post, :only => [:edit, :update, :destroy]

  def index
    @posts = Post.ordered_by_published_at.
                  page(params.fetch(:page,1))
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])

    if params[:xhr]

      if @post.save
        render :json => @post
      else
        render :json => {:status => "failed", 
                         :errors => @post.errors,
                         :slug => @post.slug}
      end

    else

      if @post.save
        flash[:notice] = "Post adicionado com sucesso."
        redirect_to :action => :index
      else
        render :action => :new
        flash[:alert] = "Não foi possível adicionar o post"
      end

    end
  end

  def edit
  end

  def update

    if params[:xhr]
      if @post.update_attributes(params[:post])
        render :json => @post
      else
        render :json => {:status => "failed", 
                         :errors => @post.errors,
                         :slug => @post.slug}
      end
    else
      if @post.update_attributes(params[:post])
        redirect_to :action => :index
        flash[:notice] = "Post atualizado com sucesso."
      else
        render :action => :edit 
        flash[:alert] = "Não foi possível atualizar o post."
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    render :template => "posts/show",
           :layout => "application"
  end

  def destroy
    if @post.destroy
      flash[:notice] = "Post removido com sucesso." 
    end
    redirect_to :action => :index
  end

  protected
  def get_post
    @post = Post.find(params[:id])
  end

end
