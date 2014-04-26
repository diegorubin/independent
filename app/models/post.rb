class Post
  include Mongoid::Document
  include Rankable

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

  embeds_many :comments, :as => :commentable
  embeds_many :post_links
  
  accepts_nested_attributes_for :post_links

  index(
    [
      [ :date, Mongo::DESCENDING ],
      [ :slug, Mongo::DESCENDING ],
      [ :published ]
    ],
    :unique => true
  )

  # Validates
  validates_presence_of :title
  validates_presence_of :body
  validates_presence_of :slug

  validates_format_of :tags, 
                      :with => /^([^,]+,)*[^,]+$/i,
                      :allow_blank => true

  # Callbacks
  before_validation :sanitize_texts, :generate_slug
  before_save :generate_date, :generate_updated_date
  after_save :generate_widget, :clear_links
  after_destroy :generate_widget

  # Scopes
  scope :find_by_slug, lambda { |date, slug|
    where(:date => date, :slug => slug) 
  }

  scope :ordered_by_published_at, lambda {
    order_by([["published_at", "desc"]])
  }

  def find_comment_by_id(comment_id)
    check_comments(comments,comment_id)
  end

  private
  def clear_links
    post_links.each{|pl| pl.destroy if pl.removed}
  end

  def check_comments(comments,comment_id)
    comments.each do |comment|
      c = check_comments(comment.child_comments,comment_id)
      return c if c
      return comment if comment_id == comment.id.to_s
    end
    nil
  end

  def sanitize_texts
    write_attribute(:title, title.sanitize) if title
    write_attribute(:resume, resume.sanitize) if resume
  end

  def generate_slug
    return if title.blank? || !slug.blank?

    slug = title.no_accent
    slug.downcase!
    slug.gsub!(/[\s_]/,'-')
    slug.gsub!(/[^A-Za-z-]/,'')

    write_attribute(:slug, slug)
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

  def generate_widget
    LatestPosts.generate
  end
end
