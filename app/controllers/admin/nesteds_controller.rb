class Admin::NestedsController < AdminController

  before_filter :get_widget

  def new
    @config = @widget.config
    @object = @config.send(params[:model]).build

    @owner = @config.class.name.underscore
    @attrs = @object.class.name.underscore.pluralize
    @attrs += '_attributes'

    @index = Time.now.to_i

    render layout: false
  end

  private
  def get_widget
    @widget = Widget.find(params[:widget_id])
  end

end

