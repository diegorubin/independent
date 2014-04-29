class User
  include Mongoid::Document

  # Attributes
  field :email,   type: String
  field :name,    type: String
  field :blocked, type: Boolean, default: false

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, 
                    confirmation: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

end
