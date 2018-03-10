class Admin::SettingsController < Admin::BaseController

  def index
    current_theme = get_setting_value('global.current_theme')
    by_categories = klass.admin_list(current_theme).group_by{|s| s.category}
    by_domains = {}
    by_categories.each do |category, settings| 
      by_domains[category] = settings.group_by{|s| s.domain || 'default'}
    end
    set_object_variable(by_domains, false)
  end

end

