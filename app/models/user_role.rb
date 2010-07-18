class UserRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role

  validates_presence_of :user, :role
end
