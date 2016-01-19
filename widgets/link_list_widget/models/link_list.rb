class LinkList
  include Mongoid::Document
  include AdminForm::Settings

  field :title, type: String

  embeds_many :links
  accepts_nested_attributes_for :links, allow_destroy: true

  def self.list
    links
  end

end

