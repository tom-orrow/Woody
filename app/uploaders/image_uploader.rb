# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  include CarrierWave::MiniMagick

  version :thumb do
    process eager: true
    process resize_to_fill: [350, 200]
  end

  def default_url
    "/assets/missing.png"
  end
end
