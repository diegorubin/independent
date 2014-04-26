class PresentationsController < ApplicationController

  def show
    @presentation = Presentation.find_by_slug(params[:slug]).first
    raise PresentationNotFound unless @presentation

    if params[:fullscreen]
      render :template => "presentations/fullscreen",
             :layout => "presentation"
    else
      @comments = @presentation.comments
    end
  end

  def index
    @presentations = Presentation.where(:published => true).
                                  ordered_by_published_at.
                                  page(params.fetch(:page,1)) 
  end

end
