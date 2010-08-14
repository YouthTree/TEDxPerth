class BannerItem < ActiveRecord::Base

  validates_presence_of :title, :url, :description, :image
  
  mount_uploader :image, BannerItemUploader
  
  def self.published
    where '(published_after IS NULL OR published_after <= ?) AND (published_until IS NULL OR published_until >= ?)', Time.now, Time.now
  end
  
  def published?
    (published_after.blank? || published_after <= Time.now) && (published_until.blank? || published_until >= Time.now)
  end
  
end
