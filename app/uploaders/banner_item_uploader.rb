# encoding: utf-8

class BannerItemUploader < CarrierWave::Uploader::Base
  # include CarrierWave::RMagick
  # include CarrierWave::ImageScience

  storage :file

  def store_dir
    "uploads/banner-items"
  end

  # Process files as they are uploaded.
  #     process :scale => [200, 300]
  #
  #     def scale(width, height)
  #       # do something
  #     end

  # Create different versions of your uploaded files
  #     version :thumb do
  #       process :scale => [50, 50]
  #     end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  def generated_filename
    @generated_filename ||= "#{self.class.uuid.generate}#{File.extname(original_filename)}"
  end
  
  def filename
    generated_filename if original_filename
  end
  
  def self.uuid
    @uuid ||= UUID.new
  end

end
