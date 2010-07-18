class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role

  validates_presence_of :user, :role
end

# == Schema Information
#
# Table name: user_roles
#
#  id         :integer         not null, primary key
#  user_id    :integer         not null
#  role_id    :integer         not null
#  created_at :datetime
#  updated_at :datetime
#

