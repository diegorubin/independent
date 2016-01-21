class GalleryItem
  include Mongoid::Document

  field :title, type: String
  field :slug, type: String

  embedded_in :gallery

end

