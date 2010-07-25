class TedVideo < ActiveRecord::Base
  
  belongs_to :event
  
  validates_presence_of :url
  validates_url_format_of :url
  
  before_save :automatically_get_response
  
  def automatically_get_response
    get_embedly_response unless raw_embedly_response?
  end
  
  def get_embedly_response
    embedly = Embedly[self.url, {:max_width => 700, :max_height => 520}]
    @to_embedly               = embedly
    self.raw_embedly_response = embedly.to_json
    self.embed_code           = normalize_embed_code
  end
  
  def title
    to_embedly[:title].gsub("| Video on TED.com", '')
  end
  
  def description
    to_embedly[:description].gsub(/^TED Talks /, '')
  end
  
  def to_embedly
    @to_embedly ||= begin
      automatically_get_response
      Embedly.from_json(url, raw_embedly_response)
    end
  end
  
  def normalize_embed_code
    embedly = self.to_embedly
    html5_code = Nokogiri::HTML.fragment(embedly[:html5]).children.first
    flash_code = Nokogiri::HTML.fragment(embedly[:html]).children.first
    html5_code.remove_attribute "id"
    html5_code.add_child flash_code
    return html5_code.to_html
  end
  
end

# == Schema Information
#
# Table name: ted_videos
#
#  id                   :integer(4)      not null, primary key
#  url                  :string(255)
#  embed_code           :text
#  raw_embedly_response :text
#  event_id             :integer(4)
#  created_at           :datetime
#  updated_at           :datetime
#

