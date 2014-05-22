class Admin::ImagesController < Admin::BaseController

  def show
    redirect_to @image.file.url
  end

end

