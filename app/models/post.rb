class Post
  include Mongoid::Document

  include Commentable
  include Publishable
  include Rankable
  include Slugable

  paginates_per 10

  field :title,        :type => String
  field :resume,       :type => String
  field :author,       :type => String
  field :body,         :type => String
  field :updated_at,   :type => DateTime

  field :external_js,  :type => String
  field :external_css, :type => String

  field :tags,         :type => String

  field :pageviews,    :type => Integer, :default => 0

  # Field for SEO
  field :metadescription,  :type => String

  
  #index(
  #  [
  #    [ :date, Mongo::DESCENDING ],
  #    [ :slug, Mongo::DESCENDING ],
  #    [ :published ]
  #  ],
  #  :unique => true
  #)

  # Validates
  validates_presence_of :title
  validates_presence_of :body

  validates_format_of :tags, 
                      :with => /\A([^,]+,)*[^,]+\z/i,
                      :allow_blank => true

  # Callbacks
  before_validation :sanitize_texts

  # Scopes
  scope :admin_list, lambda {
  }

  def self.admin_attributes
    [:title, :resume, :author, :body, :tags, :metadescription]
  end

  private
  def sanitize_texts
    write_attribute(:title, title.sanitize) if title
    write_attribute(:resume, resume.sanitize) if resume
  end

end

