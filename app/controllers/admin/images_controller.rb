class Admin::ImagesController < Admin::BaseController

  def show
    super
    redirect_to @image.file.url
  end

end

