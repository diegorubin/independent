# encoding: utf-8

class ThemeUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "#{Rails.root.to_s}/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

end

