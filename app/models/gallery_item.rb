class GalleryItem
  include Mongoid::Document

  field :title,       type: String
  field :description, type: String
  field :slug,        type: String
  field :position,    type: Integer

  embedded_in :gallery

  def image_url(version)
    @image ||= Image.where(slug: slug).first
    if @image
      @image.file.send(version).url
    else
      "/images/#{version}_fallback.png"
    end
  end

end

