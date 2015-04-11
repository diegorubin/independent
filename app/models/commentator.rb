class Commentator
  include Mongoid::Document
  include Gravtastic

  gravtastic :size => 60

  # Attributes
  field :name,               type: String
  field :email,              type: String
  field :active,             type: Boolean, default: true
  field :number_of_comments, type: Integer, default: 0

  validates :email, presence: true, uniqueness: true

  # Scopes
  scope :admin_list, lambda { order([['name', 'asc']]) }

end
