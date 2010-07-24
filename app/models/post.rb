class Post < ActiveRecord::Base

  acts_as_indexed :fields => [:title, :rendered_content], :if => Proc.new { |post| post.published? }
  
  validates_presence_of :title, :content
  
  is_publishable
  is_convertable :content
  is_sluggable   :title
  
  scope :for_listing, select('title, cached_slug, published_at, id')
  scope :for_sidebar, ordered.published.for_listing

  def self.find_using_preview_key(key)
    where(:preview_key => key).first
  end

  before_save :generate_preview_key
  before_save :generate_summarized_content

  def self.generate_uuid
    @uuid ||= UUID.new
    @uuid.generate
  end

  def generate_preview_key
    self.preview_key ||= self.class.generate_uuid
  end
  
  def generate_summarized_content
    if rendered_summary.blank? || content_changed?
      self.rendered_summary = summary_from_content
    end
  end
  
  def summary_from_content
    content.blank? ? "" : Nokogiri::HTML(content).at('p').try(:to_html).try(:html_safe)
  rescue
    ""
  end

  def summary_as_html
    rendered_summary.to_s.html_safe
  end
  
end

# == Schema Information
#
# Table name: posts
#
#  id               :integer(4)      not null, primary key
#  title            :string(255)
#  published_at     :datetime
#  rendered_summary :text
#  content          :text
#  rendered_content :text
#  format           :string(255)
#  preview_key      :string(255)
#  cached_slug      :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

