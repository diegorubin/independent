class Admin::SettingsController < Admin::BaseController

  def index
    current_theme = get_setting_value(:current_theme)
    set_object_variable(
      klass.admin_list(current_theme).page(params.fetch(:page,1)), 
      false
    )
  end

end

