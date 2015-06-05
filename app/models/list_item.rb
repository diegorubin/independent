class ListItem
  include Mongoid::Document

  include Rankable
  include Searchable
 
  paginates_per 10

  field :resource_type,      type: String
  field :resource_id,        type: String
  field :title,              type: String
  field :resume,             type: String

  field :image,              type: String

  field :number_of_comments, type: Integer
  field :pageviews,          type: Integer

  field :published_at,       type: DateTime
  field :author,             type: String

  field :slug,               type: String
  field :date,               type: String

  field :category,           type: String
  field :tags,               type: String
  field :words_index,        type: Array

  validates_presence_of :resource_type, :resource_id, :published_at, 
                        :slug, :category

  #Scopes
  scope :ordered_by_published_at, -> {
    order([["published_at", "desc"]])
  }                     

end

