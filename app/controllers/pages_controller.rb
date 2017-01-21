class PagesController < SiteController

  def show
    @page = Page.publisheds.find_by_simple_slug(params[:slug]).first
  end

end

