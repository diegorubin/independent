class LinkList
  include Mongoid::Document

  embeds_many :links
  accepts_nested_attributes_for :links

  def self.list
    links
  end

end

