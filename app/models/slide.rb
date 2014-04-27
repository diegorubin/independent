class Slide
  include Mongoid::Document

  field :file,     :type => String
  field :notes,    :type => String
  field :position, :type => Integer

  embedded_in :presentation

  mount_uploader :file, SlideUploader

end

