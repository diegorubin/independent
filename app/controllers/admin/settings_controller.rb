class Admin::SettingsController < Admin::BaseController

  def index
    current_theme = get_setting_value('global.current_theme')
    set_object_variable(
      klass.admin_list(current_theme).group_by{|s| s.category}, 
      false
    )
  end

end

