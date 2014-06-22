# encoding: utf-8
class CkeditorPictureUploader < CarrierWave::Uploader::Base
  include Ckeditor::Backend::CarrierWave
  include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave

  [:extract_content_type, :set_size, :read_dimensions].each do |method|
    define_method :"#{method}_with_cloudinary" do
      send(:"#{method}_without_cloudinary") if self.file.is_a?(CarrierWave::SanitizedFile)
      {}
    end
    alias_method_chain method, :cloudinary
  end

  process :read_dimensions

  # Create different versions of your uploaded files:
  version :thumb do
    process eager: true
    process :resize_to_fill => [118, 100]
  end

  version :content do
    process eager: true
    process :resize_to_limit => [800, 800]
  end

  def extension_white_list
    Ckeditor.image_file_types
  end
end
