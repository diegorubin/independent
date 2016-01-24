class Presentation
  include Mongoid::Document
  include AdminForm::Settings

  include Commentable
  include Listable
  include Publishable
  include Rankable
  include Searchable
  include Slugable
  include Taggable

  paginates_per 10

  field :title,  type: String
  field :image,  type: String

  # Field for SEO
  field :metadescription,  type: String

  form_field :icon, 'image'

  mount_uploader :file, PresentationUploader

  embeds_many :slides
  embeds_many :comments, :as => :commentable

  # validations
  validates_presence_of :title, :resume, :author, :category

  # Callbacks
  after_create :export_images

  # Scopes
  scope :admin_list, lambda {
    order([['published', 'desc'], ['published_at', 'desc']])
  }

  def self.admin_attributes
    [:title, :resume, :author, :category, :tags, :slug, :file, :published]
  end

  def export_images
    return if file.current_path.blank?
    images = 
      RGhost::Convert.new(file.current_path).to :jpeg, :multipage => true

    self.slides.destroy_all
    images.sort.each_with_index do |image,i|
      slide = Slide.new
      slide.file = File.open(image)
      slide.position = i

      self.slides << slide
    end
    
    self.save
  end

end

