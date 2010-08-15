# encoding: utf-8

class BannerItemUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  resize_to_fill 940, 300
  convert 'jpg'
  storage :file

  def store_dir
    "uploads/banner-items"
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
