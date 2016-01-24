class Gallery
  include Mongoid::Document

  include Commentable
  include Listable
  include Publishable
  include Rankable
  include Slugable
  include Taggable

  # Fields
  field :title, type: String
  field :image, type: String

  embeds_many :items, class_name: 'GalleryItem', order: :position.asc
  accepts_nested_attributes_for :items, allow_destroy: true

  # Validations
  validates :title, presence: true

  # Scopes
  scope :admin_list, lambda {}

  def self.admin_attributes
    [:title, :slug, :published, :tags]
  end

end

