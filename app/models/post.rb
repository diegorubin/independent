class Post
  include Mongoid::Document

  include Commentable
  include Listable
  include Publishable
  include Rankable
  include Searchable
  include Slugable
  include Taggable

  paginates_per 10

  field :title,        type: String
  field :resume,       type: String
  field :author,       type: String
  field :body,         type: String

  field :external_js,  type: String
  field :external_css, type: String

  field :category,     type: String

  # Field for SEO
  field :metadescription, type: String

  # Validates
  validates_presence_of :category
  validates_presence_of :title
  validates_presence_of :body
  validates_presence_of :author

  # Callbacks
  before_validation :sanitize_texts

  # Scopes
  scope :admin_list, lambda {
    order([['published', 'desc'], ['title', 'asc']])
  }

  def self.admin_attributes
    [
      :title, :resume, :author, :body, :tags, :metadescription, 
      :slug, :published, :category
    ]
  end

  private
  def sanitize_texts
    write_attribute(:title, title.sanitize) if title
  end

end

