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

  def javascript_translates
    phrases = get_phrases(I18n.t(:javascript))
    content_tag 'script' do
      raw "var polyglot = new Polyglot({phrases: #{phrases.to_json}});"
    end
  end

  def add_embeds_button(title, klass, parent, partial)
    link_to(title, admin_partials_path, 
      {class: "btn btn-default add-embeds", 'data-class' => klass, 
       'data-parent' => parent, 'data-partial' => partial})
  end

  private

  def get_phrases(entry, current_path = '', keys = {})
    if entry.is_a?(Hash)
      entry.each do |key, value|
        new_path = current_path.blank? ? key : "#{current_path}.#{key}"
        keys = get_phrases(value, new_path, keys)
      end
    else
      keys[current_path] = entry
    end
    keys
  end

end

