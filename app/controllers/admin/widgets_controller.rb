class Admin::WidgetsController < Admin::BaseController

  def show
    get_object
    @config = @widget.config
  end

  def update
    @config = @widget.config
    if @config.update(get_params)
      redirect_to action: 'index'
    else
      render action: 'show'
    end
  end

  private
  def get_params
    key = @config.class.name.underscore.to_sym
    params.require(key).permit!
  end

end

