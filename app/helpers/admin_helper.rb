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

  def system_resources
    Object.constants.collect{ |sym| Object.const_get(sym) }.select do |constant| 
        constant.class == Class && constant.include?(Mongoid::Document) 
    end.collect{|c| c.name.underscore.pluralize}
  end

  def generate_preview_session
    input = "#{current_user.username}#{Time.current.to_i}"
    Digest::SHA1.hexdigest(input).to_s
  end

end

