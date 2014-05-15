module ApplicationHelper

  def return_if_active(controller_name, klass)
    klass if controller.controller_name == controller_name
  end

  def item_path(item)
    resource_path = item.resource_type.underscore
    args = [item.date, item.slug]
    send("#{resource_path}_path", *args)
  end

end

