class ListItem
  include Mongoid::Document

  include Searchable

  field :resource_type, type: String
  field :resource_id,   type: String
  field :title,         type: String
  field :resume,        type: String
  field :comments,      type: Integer
  field :published_at,  type: DateTime
  field :author,        type: String

  field :slug,          type: String
  field :date,          type: String

  field :category,      type: String
  field :tags,          type: String

  validates_presence_of :resource_type, :resource_id, :published_at, 
                        :slug, :category
                        
end

