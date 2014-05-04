class Setting
  include Mongoid::Document

  field :title,    type: String
  field :category, type: String
  field :value,    type: String
  field :theme,    type: String

  validates :title, presence: true, uniqueness: {scope: ['category']}
  validates :category, presence: true

  # Scopes
  scope :admin_list, proc {|theme|
    where(theme: theme).order([['category', 'asc']])
  }

end

