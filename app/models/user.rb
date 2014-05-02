class User
  include Mongoid::Document

  devise :database_authenticatable, :recoverable, :trackable

  # Attributes
  field :email,              type: String
  field :name,               type: String
  field :encrypted_password, type: String
  field :blocked, type: Boolean, default: false

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, 
                    confirmation: true,
                    format: {with:/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

  # Scopes
  scope :admin_list, lambda {
  }

  def self.admin_attributes
    [:blocked, :email, :email_confirmation, :name]
  end

end
