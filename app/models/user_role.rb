class UserRole < ActiveRecord::Base
  
  # N.B: Ensure no user facing forms have access to this.
  attr_accessible :all
  
  belongs_to :user
  belongs_to :role

  validates_presence_of :user, :role
end

# == Schema Information
#
# Table name: user_roles
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)      not null
#  role_id    :integer(4)      not null
#  created_at :datetime
#  updated_at :datetime
#

