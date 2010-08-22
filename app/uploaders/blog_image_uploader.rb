# encoding: utf-8

class BlogImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  resize_to_fill 700, 300
  convert 'jpg'
  storage :file

  version :medium do
    process :resize_to_fill => [340, 340]
  end
  
  version :small do
    process :resize_to_fill => [160, 160]
  end
  
  version :tiny do
    process :resize_to_fill => [100, 100]
  end

  def store_dir
    "uploads/blog-images"
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  def generated_filename
    @generated_filename ||= "#{self.class.uuid.generate}.jpg"
  end
  
  def filename
    generated_filename if original_filename
  end
  
  def self.uuid
    @uuid ||= UUID.new
  end

end
