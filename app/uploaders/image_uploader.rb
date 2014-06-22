# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  include CarrierWave::MiniMagick

  process convert: 'png'

  version :thumb do
    process eager: true
    process resize_to_fill: [350, 200]
  end

  version :medium do
    process eager: true
    process resize_to_fill: [1140, 500]
  end

  def default_url
    "/assets/missing.png"
  end
end
