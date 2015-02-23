class ApiKey
  include Mongoid::Document

  field :user_id,     type: String
  field :program,     type: String
  field :permissions, type: Hash
  field :key,         type: String

  validates :user_id, presence: true
  validates :permissions, presence: true
  validates :program, uniqueness: {scope: :user_id}, presence: true

  before_create :generate_key

  # Scopes
  scope :admin_list, lambda {}

  def self.admin_attributes
    [:permissions, :program]
  end

  def user
    @user ||= User.find(user_id)
  end

  private
  def generate_key
    self.key = SecureRandom.hex
  end

end

