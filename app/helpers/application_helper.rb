module ApplicationHelper

  def return_if_active(controller_name, klass)
    klass if controller.controller_name == controller_name
  end

end

