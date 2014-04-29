class Post
  include Mongoid::Document

  include Commentable
  include Rankable
  include Slugable

  paginates_per 10

  field :title,        :type => String
  field :resume,       :type => String
  field :author,       :type => String
  field :body,         :type => String
  field :published_at, :type => DateTime
  field :updated_at,   :type => DateTime
  field :slug,         :type => String
  field :published,    :type => Boolean

  field :external_js,  :type => String
  field :external_css, :type => String

  field :tags,         :type => String

  field :pageviews,    :type => Integer, :default => 0

  # Field used in slug
  field :date,         :type => String

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
  validates_presence_of :slug

  validates_format_of :tags, 
                      :with => /\A([^,]+,)*[^,]+\z/i,
                      :allow_blank => true

  # Callbacks
  before_validation :sanitize_texts
  before_save :generate_date, :generate_updated_date

  # Scopes
  scope :find_by_slug, lambda { |date, slug|
    where(:date => date, :slug => slug) 
  }

  scope :ordered_by_published_at, lambda {
    order_by([["published_at", "desc"]])
  }

  private
  def sanitize_texts
    write_attribute(:title, title.sanitize) if title
    write_attribute(:resume, resume.sanitize) if resume
  end

  def generate_date
    if published? && !date
      write_attribute(:date,Time.current.strftime("%Y/%m/%d"))
      write_attribute(:published_at, Time.current)
    end
  end

  def generate_updated_date
    write_attribute(:updated_at, Time.current)
  end

end

