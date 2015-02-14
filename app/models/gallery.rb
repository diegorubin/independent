class Gallery
  include Mongoid::Document

  include Publishable
  include Taggable
  include Slugable

  # Fields
  field :title, type: String
  field :images, type: Array

  # Validations
  validates :title, presence: true

  # Scopes
  scope :admin_list, lambda {}

  def self.admin_attributes
    [:title, :slug, :published, :tags]
  end

end

