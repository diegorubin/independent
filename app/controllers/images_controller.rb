class ImagesController < ApplicationController

  def show
    image = Image.publisheds.find_by_simple_slug(params[:slug]).first
    raise RecordNotFound unless image 

    redirect_to image.file.url(params.fetch(:size, :list))
  end

end

