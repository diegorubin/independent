class IconList
  include Mongoid::Document

  embeds_many :icons
  accepts_nested_attributes_for :icons, allow_destroy: true

end

