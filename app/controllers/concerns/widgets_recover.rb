module WidgetsRecover

  protected
  def widgets
    Widget.all.each do |widget|
      widget_instance = widget.config
      widget_instance_name = widget_instance.class.name.underscore
      instance_variable_set("@#{widget_instance_name}", widget_instance)
    end
  end

end

