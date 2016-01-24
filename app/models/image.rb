class Image
  include Mongoid::Document

  include Filterable
  include Publishable
  include Taggable
  include Slugable

  paginates_per 12

  # Attributes
  field :title, type: String
  mount_uploader :file, ImageUploader

  validates :title, presence: true
  validates :file, presence: true

  # Scopes
  scope :admin_list, lambda { order([['title', 'asc']]) }

  def self.admin_attributes
    [:title, :slug, :published, :file, :tags]
  end

  def self.admin_filters
    { 'title' => {type: 'regex'}, 'slug' => {type: 'regex'} }
  end

end

