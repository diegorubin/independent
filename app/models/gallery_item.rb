class GalleryItem
  include Mongoid::Document

  field :title, type: String
  field :description, type: String
  field :image, type: String

  embedded_in :gallery

end

