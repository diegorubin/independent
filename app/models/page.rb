class Page
  include Mongoid::Document

  include Publishable
  include Rankable
  include Slugable

  paginates_per 10

  field :title,        type: String
  field :body,         type: String,  default: ''
  field :pageviews,    type: Integer, default: 0

  field :external_js,  type: String
  field :external_css, type: String

  # Validates
  validates_presence_of :title
  validates_presence_of :body

  # Scopes
  scope :admin_list, lambda {}

  def self.admin_attributes
    [
      :title, :body, :tags, :metadescription, :slug, :published
    ]
  end

end

