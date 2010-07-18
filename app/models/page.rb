class Page < ActiveRecord::Base
  
  validates_presence_of :title, :content, :key
  
  is_publishable
  is_convertable :content
  is_sluggable   :title
  
  scope :renderable, includes(:rendered_content, :title, :keywords, :description)
  
  def self.[](identifier)
    where('key = :identifier OR id = :identifier', :identifier => identifier.to_s).first
  end
  
  def self.home
    self[:home] || Page.new(:title => "Welcome to TEDxPerth")
  end
  
end

# == Schema Information
#
# Table name: pages
#
#  id               :integer         not null, primary key
#  title            :string(255)
#  content          :text
#  rendered_content :text
#  published_at     :datetime
#  description      :text
#  keywords         :string(255)
#  key              :string(255)
#  cached_slug      :string(255)
#  format           :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

