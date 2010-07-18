class Event < ActiveRecord::Base
  
  validates_presence_of :name, :starts_at, :ends_at, :description, :notes
  validate :check_valid_starts_at
  validate :check_valid_ends_at
  
  has_many :roles, :as => :owner
  
  scope :viewable, where(:state => %w(published completed))
  
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
    attending.where('users.id = ?', user.id).exists?
  end
  
  def attending!(user)
    user.has_role! :attendee, self
  end
  
  def withdraw!(user)
    user.remove_role! :attendee, self
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
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  starts_at            :datetime
#  ends_at              :datetime
#  description          :text
#  rendered_description :text
#  cached_slug          :string(255)
#  notes                :text
#  rendered_notes       :text
#  state                :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

