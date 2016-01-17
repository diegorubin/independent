class Gallery
  include Mongoid::Document

  include Publishable
  include Taggable
  include Slugable

  # Fields
  field :title, type: String

  embeds_many :items, class_name: 'GalleryItem'
  accepts_nested_attributes_for :items, allow_destroy: true

  # Validations
  validates :title, presence: true

  # Scopes
  scope :admin_list, lambda {}

  def self.admin_attributes
    [:title, :slug, :published, :tags]
  end

end

