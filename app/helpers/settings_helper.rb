module SettingsHelper
  def get_setting_value(setting)
    theme, title = setting.split('.')
    settings = Setting.map_settings_by_category

    theme = current_theme if theme == 'theme'

    settings.fetch(theme, {}).fetch(title, '')
  end 

  def current_theme
    get_setting_value('global.current_theme')
  end

  def feature_enabled?(feature)
  end

end

