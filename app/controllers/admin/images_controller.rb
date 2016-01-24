class Admin::ImagesController < Admin::BaseController

  def show
    super
    redirect_to @image.file.url
  end

  def create
    params['format'] == 'json' ? create_and_return_json : super
  end

  private
  def create_and_return_json
    set_object_variable(klass.new(object_params))
    if @image.save
      render json: {image: @image}, status: 200
    else
      render json: {image: @image}, status: 422
    end
  end

end

