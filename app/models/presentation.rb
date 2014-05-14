class Presentation
  include Mongoid::Document

  include Commentable
  include Publishable
  include Rankable
  include Slugable

  paginates_per 10

  field :title,        :type => String
  field :resume,       :type => String
  field :export,       :type => Boolean,  :default => false
  field :pageviews,    :type => Integer,  :default => 0

  field :tags,   :type => String
  
  # Field for SEO
  field :metadescription,  :type => String

  mount_uploader :file, PresentationUploader

  embeds_many :slides
  embeds_many :comments, :as => :commentable

  # validations
  validates_presence_of   :title
  validates_presence_of   :slug
  validates_uniqueness_of :slug

  validates_format_of :tags, 
                      :with => /\A([^,]+,)*[^,]+\z/i,
                      :allow_blank => true

  # Callbacks
  before_validation :sanitize_texts

  # Scopes
  scope :admin_list, lambda {}

  def self.admin_attributes
    [:title, :resume, :tags, :file]
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

end

