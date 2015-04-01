class Snippet
  include Mongoid::Document

  include Rankable
  include Publishable
  include Slugable

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

  field :pageviews,  :type => Integer, :default => 0

  # Validates
  validates_presence_of :title
  validates_presence_of :code
  validates_presence_of :language

  # Scopes
  scope :admin_list, lambda {}

  def to_html
    result = code
    result.gsub!("<","&lt;")
    result.gsub!(">","&gt;")

    "<pre class='sh_#{language}'>#{result}</pre>"
  end

  def language_name
    LANGUAGES[language] || I18n.t('admin.snippets.not_found')
  end

  def resume
    I18n.t('admin.snippets.not_found')%(language_name)
  end

  def self.admin_attributes
    [:title, :code, :public, :language, :tags]
  end

end

