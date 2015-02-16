class ApiKey
  include Mongoid::Document

  field :user_id,     type: String
  field :program,     type: String
  field :permissions, type: Hash

  validates :user_id, presence: true
  validates :permissions, presence: true
  validates :program, uniqueness: {scope: :user_id}, presence: true

end

