class Admin::WidgetsController < Admin::BaseController

  def show
    klass = @widget.manifest['widget']['config_model'].constantize
    @config = klass.first || klass.new
  end

end

