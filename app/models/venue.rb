class Venue < ActiveRecord::Base
  
  attr_accessible :name, :location_name, :instructions, :address
  
  validates_presence_of :name, :location_name, :address
  
  has_many :events
  
  is_sluggable :name
  
  before_save :geocode_address

  def self.for_select
    all.map { |v| [v.to_s, v.id] }
  end

  def geocode_address
    if address.present? && needs_geocoding?
      geo = Geokit::Geocoders::GoogleGeocoder.geocode([location_name, address].compact.join(", "))
      self.lat, self.lng = geo.lat, geo.lng if geo.success
    else
      self.lat, self.lng = nil, nil
    end
  end
  
  def needs_geocoding?
    lat.blank? || lng.blank? || address.changed?
  end
  
  def to_s(joiner = ", ")
    [name, location_name].join(joiner)
  end
  
end

# == Schema Information
#
# Table name: venues
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  location_name :string(255)
#  instructions  :text
#  address       :text
#  lat           :decimal(15, 10)
#  lng           :decimal(15, 10)
#  cached_slug   :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

