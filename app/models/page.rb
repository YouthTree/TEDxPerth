class Page < ActiveRecord::Base
  extend SimpleSortable

  attr_accessible :title, :content, :key, :description, :keywords, :format,
                  :menu_title, :menu_position, :show_in_menu, :menu_subtitle
  
  validates_presence_of :title, :content, :key
  validates_presence_of :menu_subtitle, :menu_title, :if => :show_in_menu?

  acts_as_indexed :fields => [:title, :rendered_content, :description, :menu_title, :menu_subtitle],
                  :if => Proc.new { |page| page.published? }
  
  is_publishable
  is_convertable :content
  is_sluggable   :title
  is_sortable    :menu_position, :if_field => :show_in_menu
  
  scope :renderable, select('rendered_content, key, title, keywords, description')
  
  def self.for_menu
    published.sortable_items.sorted_asc.select('id, key, cached_slug, menu_subtitle, menu_title, title')
  end
  
  def self.[](identifier)
    where(:key => identifier.to_s).first
  end
  
  def self.home
    self[:home] || Page.new(:title => "Welcome to TEDxPerth")
  end
  
end

# == Schema Information
#
# Table name: pages
#
#  id               :integer(4)      not null, primary key
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
#  menu_subtitle    :string(255)
#  menu_title       :string(255)
#  menu_position    :integer(4)
#  show_in_menu     :boolean(1)      default(FALSE)
#

