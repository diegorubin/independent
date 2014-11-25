class Theme
  include Mongoid::Document

  include Uploadable

  def self.path
    Rails.root.join('themes')
  end

  private
  def load_manifest(manifest_file)
    super(manifest_file)
    create_theme_settings(self.manifest['theme']['settings'])
  end

  def create_theme_settings(settings)
    settings.each do |title, attributes|
      Setting.create({title: title, theme: self.label}.merge(attributes))
    end
  end

end

