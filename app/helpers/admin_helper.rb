module AdminHelper

  def in_action?(action_name)
    controller.action_name == action_name
  end

  def is_active?(controller_name)
    controller.controller_name == controller_name
  end

  def menu_button(title, path, klass, options = {})
    link_to(title, path, {class: "btn #{klass}"}.merge(options))
  end

  def set_active(controller_name)
    'active' if is_active?(controller_name)
  end

end

