class PresentationsController < SiteController

  def index
    @presentations = Presentation.publisheds.ordered_by_published_at.
      filters(params).page(params.fetch(:page, 1))
  end

  def show
    @presentation = Presentation.
      find_by_slug(params[:date], params[:slug]).first

    if params[:fullscreen] == 'on'
      render layout: 'presentation', template: 'presentations/fullscreen'
    end
  end

end

