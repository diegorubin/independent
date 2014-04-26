class Presentation
  include Mongoid::Document
  include Rankable

  paginates_per 10

  field :title,        :type => String
  field :resume,       :type => String
  field :slug,         :type => String
  field :published,    :type => Boolean
  field :published_at, :type => DateTime
  field :updated_at,   :type => DateTime
  field :export,       :type => Boolean,  :default => false
  field :pageviews,    :type => Integer,  :default => 0

  field :tags,   :type => String
  
  # Field for SEO
  field :metadescription,  :type => String

  mount_uploader :file, PresentationUploader

  embeds_many :slides
  embeds_many :comments, :as => :commentable

  #index(
  #  [
  #    [ :slug, Mongo::DESCENDING ],
  #    [ :published ]
  #  ],
  #  :unique => true
  #)

  # validations
  validates_presence_of   :title
  validates_presence_of   :slug
  validates_uniqueness_of :slug

  validates_format_of :tags, 
                      :with => /\A([^,]+,)*[^,]+\z/i,
                      :allow_blank => true

  # Callbacks
  before_validation :sanitize_texts, :generate_slug
  before_save :generate_updated_date, :generate_date

  # Scopes
  scope :find_by_slug, lambda { |slug|
    where(:slug => slug) 
  }

  scope :ordered_by_published_at, lambda {
    order_by([["published_at", "desc"]])
  }

  def find_comment_by_id(comment_id)
    check_comments(comments,comment_id)
  end

  def self.export_images(presentation_id)
    p = Presentation.find(presentation_id)
    return if not p.export

    images = 
      RGhost::Convert.new(p.file.current_path).to :jpeg, :multipage => true

    p.slides.destroy_all
    images.sort.each_with_index do |image,i|
      slide = Slide.new
      slide.file = File.open(image)
      slide.position = i

      p.slides << slide
    end
    
    p.export = false
    p.save
  end

  private
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

  def generate_updated_date
    write_attribute(:updated_at, Time.current)
  end

  def generate_date
    if published? && !published_at
      write_attribute(:published_at, Time.current)
    end
  end

  def check_comments(comments,comment_id)
    comments.each do |comment|
      c = check_comments(comment.child_comments,comment_id)
      return c if c
      return comment if comment_id == comment.id.to_s
    end
    nil
  end

end

