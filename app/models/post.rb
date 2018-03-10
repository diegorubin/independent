class Post
  include Mongoid::Document
  include AdminForm::Settings

  include ActAsDocument

  include Commentable
  include Filterable
  include Listable
  include Publishable
  include Rankable
  include Searchable
  include Slugable
  include Taggable

  paginates_per 10

  field :title,        type: String
  field :body,         type: String, default: ''
  field :header_image, type: String
  field :image,        type: String
  field :kindle_cover, type: String

  field :external_js,  type: String
  field :external_css, type: String

  field :domains,      type: String

  # Field for SEO
  field :metadescription, type: String

  form_field :image, 'image'
  form_field :header_image, 'image'
  form_field :kindle_cover, 'image'

  embeds_many :comments, as: :commentable

  # Validates
  validates_presence_of :category, :title, :body, :author, :resume

  # Callbacks
  before_validation :sanitize_texts

  # Scopes
  scope :admin_list, lambda {
    order([['published', 'desc'], ['published_at', 'desc']])
  }

  scope :filter_by_domain, lambda { |domain|
    where(domains: /(,|^)#{domain}(,|$)/)
  }

  def self.admin_attributes
    [
      :title, :resume, :author, :body, :tags, :metadescription, 
      :slug, :published, :category, :external_js, :external_css
    ]
  end

  def self.admin_filters
    {
      'title' => {type: 'regex'}, 'author' => {type: 'regex'},
      'slug' => {type: 'regex'}, 'body' => {type: 'regex'},
      'resume' => {type: 'regex'}, 
      'published_at' => {type: 'datetime', interval: true}
    }
  end

  private
  def sanitize_texts
    write_attribute(:title, title.sanitize) if title
  end

end

