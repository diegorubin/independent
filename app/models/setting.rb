class Setting
  include Mongoid::Document

  field :title,    type: String
  field :category, type: String
  field :value,    type: String

  validates :title, presence: true, uniqueness: {scope: ['category']}
  validates :category, presence: true

end

