class LinkList
  include Mongoid::Document

  embeds_many :links

  def self.list
    links
  end

end

