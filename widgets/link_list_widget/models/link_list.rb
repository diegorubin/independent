class LinkList
  include Mongoid::Document

  field :title, type: String

  embeds_many :links
  accepts_nested_attributes_for :links

  def self.list
    links
  end

end

