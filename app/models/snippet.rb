class Snippet
  include Mongoid::Document
  include Rankable

  paginates_per 10

  LANGUAGES = {
    "javascript" => "Javascript",
    "html" => "HTML",
    "css" => "CSS",
    "c" => "C",
    "perl" => "Perl",
    "ruby" => "Ruby"
  }

  field :title,      :type => String
  field :code,       :type => String
  field :public,     :type => Boolean
  field :language,   :type => String
  field :tags,       :type => String

  field :slug,       :type => String

  field :updated_at, :type => DateTime
  field :pageviews,  :type => Integer, :default => 0

  # Validates
  validates_presence_of :title
  validates_presence_of :code
  validates_presence_of :language
  validates_presence_of :slug

  # Callbacks
  before_validation :generate_slug
  before_save :generate_updated_date
  after_save :generate_list

  # Scopes
  scope :by_slug, lambda { |slug|
    where(:slug => slug) 
  }

  scope :ordered_by_published_at, lambda {
    order_by([["published_at", "desc"]])
  }

  def to_html
    result = code
    result.gsub!("<","&lt;")
    result.gsub!(">","&gt;")

    "<pre class='sh_#{language}'>#{result}</pre>"
  end

  def language_name
    LANGUAGES[language] || "Não informada"
  end

  def resume
    "Linguagem: #{language_name}"
  end

  private
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

  def generate_list
    Tag.delay.generate_list
  end

end
