module SettingsHelper
  def get_setting_value(setting)
    theme, title = setting.split('.')
    settings = Setting.map_settings_by_category(request.host)

    theme = current_theme if theme == 'theme'

    settings.fetch(theme, {}).fetch(title, '')
  end 

  def current_theme
    get_setting_value('global.current_theme')
  end

  def feature_enabled?(feature)
    features = Setting.features
    features[feature] == 'enabled'
  end

end

