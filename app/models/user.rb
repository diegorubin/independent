class User
  include Mongoid::Document

  devise :database_authenticatable, :recoverable, :trackable

  # Attributes
  field :email,              type: String
  field :name,               type: String
  field :username,           type: String
  field :blocked,            type: Boolean, default: false

  # Devise attributes
  field :reset_password_token, type: String
  field :encrypted_password,   type: String
  field :current_sign_in_at,   type: DateTime
  field :last_sign_in_at,      type: DateTime
  field :current_sign_in_ip,   type: String
  field :last_sign_in_ip,      type: String
  field :sign_in_count,        type: Integer

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, 
                    confirmation: true,
                    format: {with:/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

  # Scopes
  scope :admin_list, lambda {
  }

  def self.admin_attributes
    [
      :blocked, :email, :email_confirmation, :name, 
      :password, :password_confirmation, :username
    ]
  end

  # Hack for devise + mongoid session
  class << self
    def serialize_from_session(key, salt)
      if key.respond_to?(:[]) && key[0].respond_to?(:[])
        record = to_adapter.get(key[0]['$oid'])
        record if record && record.authenticatable_salt == salt
      else
        super
      end
    end
  end

end
