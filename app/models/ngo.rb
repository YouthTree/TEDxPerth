class Ngo < ActiveRecord::Base
  
  validates_presence_of :name, :url
  validates_url_format_of :url
  
  state_machine :state do
    state :submitted
    state :approved
    state :presented
    state :archived
    
    event :approve do
      transition :submitted => :approved
    end
    
    event :present do
      transition :approved => :presented
    end
    
    event :archive do
      transition any => :archived
    end
    
  end
  
  def state_events_for_select
    state_events.map do |se|
      name = ::I18n.t("#{self.class.model_name.underscore}.#{se}", :default => se.to_s.humanize, :scope => "ui.state_events")
      [name, se]
    end
  end
  
  def representatives
    User.with_role(:representative, self)
  end
  
  def representative_ids
    UserRole.select(:user_id).where(:role_id => representative_role.id).all.map { |u| u.user_id }
  end
  
  def representative_role
    @role ||= Role[:representative, self]
  end
  
  def representative_ids=(ids)
    ids = Array(ids).map { |i| i.to_i }.uniq
    current_ids = self.representative_ids
    UserRole.where(:user_id => (current_ids - ids), :role_id => representative_role.id).delete_all
    (ids - current_ids).each { |id| UserRole.create(:role_id => representative_role.id, :user_id => id) }
  end
  
  def represented_by?(user)
    user.has_role? :representative, self
  end
  
  def represented_by!(user)
    user.has_role! :representative, self
  end
  
  def no_longer_represented_by!(user)
    user.remove_role! :representative, self
  end
  
end

# == Schema Information
#
# Table name: ngos
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  url         :string(255)
#  cached_slug :string(255)
#  state       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

