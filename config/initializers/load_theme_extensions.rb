module LoadThemeExtensions
  extend SettingsHelper

  CUSTOM_RESOURCES = []

  def self.load
    begin
      theme = current_theme
      "#{theme.camelize}Theme".constantize
      puts "loading #{theme} extensions"
    rescue
      puts "#{theme} does not have valid extensions"
    end
  end
end

LoadThemeExtensions.load

