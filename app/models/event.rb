class Event < ActiveRecord::Base
  extend RejectIfHelper
  
  validates_presence_of :name, :starts_at, :ends_at, :description, :notes
  validate :check_valid_starts_at
  validate :check_valid_ends_at
  
  has_many :roles, :as => :owner
  
  has_many :ted_videos
  
  accepts_nested_attributes_for :ted_videos, :reject_if => reject_if_proc, :allow_destroy => true
  
  scope :viewable, where(:state => %w(published completed)).includes(:ted_videos)
  scope :for_sidebar, select('id, name, starts_at, ends_at, cached_slug')
  
  def self.upcoming
    viewable.order('starts_at ASC').where('starts_at >= ?', Time.now)
  end
  
  def self.completed
    viewable.orders('starts_at DESC').where('starts_at <= ?', Time.now)
  end
  
  def self.next
    upcoming.first
  end
  
  is_sluggable :name
  
  is_convertable :description, :notes, :validate => false
  validate_convertable_format :description, :notes
  
  state_machine :state, :initial => :pending do
    state :pending
    state :published
    state :completed
    
    event :publish do
      transition :pending => :published
    end
    
    event :complete do
      transition :published => :completed
    end
  end
  
  # Hack hack hack!
  
  def attending
    User.with_role(:attendee, self)
  end
  
  def attending?(user)
    attending.where(:users => {:id => user.id}).exists?
  end
  
  def attending!(user)
    user.has_role! :attendee, self
  end
  
  def withdraw!(user)
    user.remove_role! :attendee, self
  end
  
  def state_events_for_select
    state_events.map do |se|
      name = ::I18n.t("#{self.class.model_name.underscore}.#{se}", :default => se.to_s.humanize, :scope => "ui.state_events")
      [name, se]
    end
  end
  
  # Permissions control.
  
  def can_attend?(user)
    can_change_attendance? && !attending?(user)
  end
  
  def can_withdraw?(user)
    can_change_attendance? && attending?(user)
  end
  
  def can_change_attendance?
    published? && starts_at < Time.now
  end
  
  protected
  
  def check_valid_starts_at
    if starts_at.present? && starts_at < Time.now
      errors.add :starts_at, "must be in the future."
    end
  end
  
  def check_valid_ends_at
    if starts_at.present? && ends_at.present? && ends_at <= starts_at
      errors.add :ends_at, "must be after the start of this event."
    end
  end
  
end

# == Schema Information
#
# Table name: events
#
#  id                   :integer(4)      not null, primary key
#  name                 :string(255)
#  starts_at            :datetime
#  ends_at              :datetime
#  description_format   :string(255)
#  description          :text
#  rendered_description :text
#  cached_slug          :string(255)
#  notes_format         :string(255)
#  notes                :text
#  rendered_notes       :text
#  state                :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

