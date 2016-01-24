class GalleryItem
  include Mongoid::Document

  field :title,       type: String
  field :description, type: String
  field :slug,        type: String
  field :position,    type: Integer

  embedded_in :gallery

  def image_url(version)
    @image ||= Image.find_by(slug: slug)
    @image.file.send(version).url
  end

end

