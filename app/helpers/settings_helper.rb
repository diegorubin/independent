module SettingsHelper
   def get_setting_value(setting)
     theme, title = setting.split('.')
     settings = prepare_settings

     settings.fetch(theme, {}).fetch(title, '')
  end 

  private
  def prepare_settings
    settings = {}
    Setting.map_settings_by_category.each do |item|
      _id = item['_id']
      value = item['value']

      if value.has_key?(_id)
        settings[_id] = value[_id]
      else
        settings[_id] = value
      end
    end
    settings
  end

end

