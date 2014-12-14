# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Create different versions of your uploaded files:

  version :list do
    process :resize_to_fit => [627, 10000]
  end

  version :thumb do
    process :resize_to_fit => [100, 100]
  end

  version :small do
    process :resize_to_fit => [32, 32]
  end

  version :micro do
    process :resize_to_fit => [16, 16]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end

