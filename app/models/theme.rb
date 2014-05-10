class Theme
  include Mongoid::Document

  # Attributes
  field :title,    type: String
  field :label,    type: String
  field :files,    type: Array
  field :manifest, type: Hash

  mount_uploader :file, ThemeUploader

  validates :title, presence: true
  validates :label, presence: true, uniqueness: true

  # Scopes
  scope :admin_list, lambda {}

  # Callbacks
  before_validation :extract_file

  def self.admin_attributes
    [:title, :label, :file]
  end

  def self.path
    Rails.root.join('themes')
  end

  private
  def extract_file
    return if file.path.blank?
    Zip::File.open(file.path) do |zip_file|
      load_manifest(zip_file.get_entry('manifest.yml'))

      zip_file.entries.each{|f| copy_file(f)}
    end
  end

  def load_manifest(manifest_file)
    manifest = YAML::load(manifest_file.get_input_stream.read)

    self.manifest = manifest
    self.files = ['manifest.yml']
    self.title = self.manifest['theme']['name']
    self.label = self.manifest['theme']['label']
    create_theme_settings(self.manifest['theme']['settings'])

  end

  def copy_file(ziped_file)
    return if ziped_file.name == 'manifest.yml'
    self.files << ziped_file.name
    ziped_file.extract(Theme.path.join(ziped_file.name))
  end

  def create_theme_settings(settings)
    settings.each do |title, attributes|
      Setting.create({title: title, theme: self.label}.merge(attributes))
    end
  end

end

