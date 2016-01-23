class GalleryItem
  include Mongoid::Document

  field :title, type: String
  field :slug, type: String

  embedded_in :gallery

  def image_url(version)
    @image ||= Image.find_by(slug: slug)
    @image.file.send(version).url
  end

end

