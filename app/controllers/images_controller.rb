class ImagesController < ApplicationController

  def show
    image = Image.publisheds.find_by_simple_slug(params[:slug]).first
    raise RecordNotFound unless image 

    size = params.fetch(:size, :list)
    if size == 'original'
      redirect_to image.file.url
    else
      redirect_to image.file.url(size)
    end
  end

end

