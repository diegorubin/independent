class Theme
  include Mongoid::Document

  # Attributes
  field :title, type: String
  field :label, type: String

  validates :title, presence: true
  validates :label, presence: true, uniqueness: true

end

