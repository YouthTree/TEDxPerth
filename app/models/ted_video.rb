class TedVideo < ActiveRecord::Base
  
  belongs_to :event
  
  validates_presence_of :url, :event
  validates_url_format_of :url
  
  before_save :automatically_get_response
  
  def automatically_get_response
    unless raw_embedly_response?
      embedly = Embedly[self.url]
      self.raw_embedly_response = embedly.to_json
      self.embed_code           = embedly[:html]
    end
  end
  
  def title
    to_embedly[:title]
  end
  
  def to_embedly
    automatically_get_response
    Embedly.from_json(url, raw_embedly_response)
  end
  
end

# == Schema Information
#
# Table name: ted_videos
#
#  id                   :integer         not null, primary key
#  url                  :string(255)
#  embed_code           :text
#  raw_embedly_response :text
#  event_id             :integer
#  created_at           :datetime
#  updated_at           :datetime
#

