class GalleriesController < SiteController

  def show
    @gallery = Gallery.find_by_slug(params[:date], params[:slug]).first
  end

end

