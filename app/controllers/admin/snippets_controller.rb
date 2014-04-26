class Admin::SnippetsController < AdminController
  before_filter :get_snippet, :only => [:show, :edit, :update, :destroy]

  def index
    @snippets = Snippet.page(params.fetch(:page,1))
    
    respond_to do |format|
      format.html {render :action => :index}
      format.json {render :json => @snippets}
    end

  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(params[:snippet])
    if @snippet.save
      redirect_to :action => :index
      flash[:notice] = "Snippet adicionado com sucesso."
    else
      render :action => :new
      flash[:alert] = "Não foi possível adicionar o snippet."
    end
  end

  def edit
  end

  def update
    if@snippet.update_attributes(params[:snippet])
      redirect_to :action => :index
      flash[:notice] = "Snippet atualizado com sucesso."
    else
      render :action => :edit
      flash[:alert] = "Não foi possível atualizar o snippet."
    end
  end

  def destroy
    if @snippet.destroy
      flash[:notice] = "Snippet removido com sucesso."
    else
      flash[:notice] = "Não foi possível remover o snippet."
    end
    redirect_to :action => :index
  end

  def show
  end

  private
  def get_snippet
    @snippet = Snippet.find(params[:id])
  end

end
