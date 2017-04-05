# encoding: utf-8

class SlideUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process :resize_to_fit => [120, 240]
  end

  version :presentation do
    process :resize_to_fit => [550, 1100]
  end

  version :full do
    process :resize_to_fit => [1280, 2400]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
