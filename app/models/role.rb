class Role < ActiveRecord::Base

  validates_presence_of :name
  belongs_to :owner, :polymorphic => true

  has_many :user_roles
  has_many :roles, :through => :user_roles, :dependent => :destroy

  class << self

    # Returns the role with a given name and object.
    def [](name, obj = nil)
      scope = self.for(name, obj)
      scope.first || scope.create
    end

    # Returns a relation for the given name and object.
    def for(name, obj = nil)
      on(obj).where(:name => name.to_s.downcase)
    end

    # Returns a relation for all roles on a given object.
    def on(owner = nil)
      if owner.present?
        where :owner_id => owner.id, :owner_type => owner.class.name
      else
        where :owner_id => nil, :owner_type => nil
      end
    end

  end

  # Downcase the name before saving it, just ensuring consistency.
  def name=(value)
    write_attribute :name, value.to_s.downcase
  end

end

# == Schema Information
#
# Table name: roles
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  owner_id   :integer
#  owner_type :string(255)
#  created_at :datetime
#  updated_at :datetime
#

