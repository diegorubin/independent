class Admin::PresentationsController < AdminController

  before_filter :get_presentation, :only => [:edit, :update, :destroy]

  def index
    @presentations = Presentation.ordered_by_published_at.
                                  page(params.fetch(:page,1))
  end

  def new
    @presentation = Presentation.new
  end

  def create
    @presentation = Presentation.new(params[:presentation])
    @presentation.export = true
    if @presentation.save
      redirect_to :action => :index
      flash[:notice] = "Apresentação adicionada com sucesso."
    else
      render :action => :new
      flash[:alert] = "Não foi possível adicionar a apresentação."
    end
  end

  def edit
  end

  def update
    params[:presentation][:export] = true if params[:presentation][:file]
    if @presentation.update_attributes(params[:presentation])
      redirect_to :action => :index
      flash[:notice] = "Apresentação atualizada com sucesso."
    else
      render :action => :edit 
      flash[:alert] = "Não foi possível atualizar a apresentação."
    end
  end

  def show
    @presentation = Presentation.find(params[:id])
    render :template => "presentations/show",
           :layout => "application"
  end

  def destroy
    if @presentation.destroy
      flash[:notice] = "Apresentação removida com sucesso." 
    end
    redirect_to :action => :index
  end

  protected
  def get_presentation
    @presentation = Presentation.find(params[:id])
  end

end
