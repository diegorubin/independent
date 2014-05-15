class PresentationsController < ApplicationController

  layout :set_current_theme

  prepend_before_filter :prepend_view_paths

  def index
    @presentations = Presentation.publisheds.ordered_by_published_at.
      filters(params).page(params.fetch(:page, 1))
  end

  def show
    @presentation = Presentation.
      find_by_slug(params[:date], params[:slug]).first
  end

end

