module Uploadable
  extend ActiveSupport::Concern

  included do

    # Attributes
    field :title,    type: String
    field :label,    type: String
    field :files,    type: Array
    field :manifest, type: Hash

    mount_uploader :file, AssetUploader

    validates :title, presence: true
    validates :label, presence: true, uniqueness: true

    # Scopes
    scope :admin_list, lambda {}

    # Callbacks
    before_validation :extract_file

    def self.admin_attributes
      [:title, :label, :file]
    end

  end

  def load_manifest(manifest_file)
    manifest = YAML::load(manifest_file.read)
    prefix = self.class.name.underscore

    self.manifest = manifest
    self.files = ['manifest.yml']
    self.title = self.manifest[prefix]['name']
    self.label = self.manifest[prefix]['label']
  end

  private
  def extract_file
    return if file.path.blank?
    Zip::File.open(file.path) do |zip_file|
      load_manifest(zip_file.get_entry('manifest.yml').get_input_stream)

      zip_file.entries.each{|f| copy_file(f)}
    end
  end

  def copy_file(ziped_file)
    return if ziped_file.name == 'manifest.yml'
    self.files << ziped_file.name
    ziped_file.extract(self.class.path.join(ziped_file.name)){ true }
  end

end

