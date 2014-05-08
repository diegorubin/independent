class Theme
  include Mongoid::Document

  # Attributes
  field :title, type: String
  field :label, type: String

  mount_uploader :file, ThemeUploader

  validates :title, presence: true
  validates :label, presence: true, uniqueness: true

  # Scopes
  scope :admin_list, lambda {}

  def self.admin_attributes
    [:title, :label, :file]
  end

end

