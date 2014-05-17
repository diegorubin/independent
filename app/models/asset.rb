class Asset
  include Mongoid::Document

  include Publishable
  include Slugable

  # Attributes
  field :title, type: String

  mount_uploader :file, AssetUploader

  validates :title, presence: true
  validates :file, presence: true

  # Scopes
  scope :admin_list, lambda {}

  def self.admin_attributes
    [:title, :slug, :published, :file]
  end

end

