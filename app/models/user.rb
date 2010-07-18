class User < ActiveRecord::Base
  
  def self.for_select
    all.map { |u| [u.to_s, u.id] }
  end
  
  attr_accessible :login, :password, :password_confirmation, :email, :display_name, :mailing_list_ids, :origin
  
  has_many :user_roles, :dependent => :destroy
  has_many :roles, :through => :user_roles
  
  is_sluggable :name

  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::BCrypt
    c.validate_email_field  true
    c.account_merge_enabled true
    c.account_mapping_mode  :internal
  end
  
  def to_s
    display_name.present? ? display_name : login
  end
  alias name to_s
  
  def name_changed?
    display_name_changed? || login_changed?
  end
  
  def name_was
    if display_name_changed?
      display_name_was
    elsif display_name.blank? && login_changed?
      login_was
    else
      name
    end
  end
  
  def admin?
    has_role? :admin
  end
  
  def can?(action, object)
    return true if admin?
    method_name = :"#{action}able_by?"
    object.respond_to?(method_name) && object.send(method_name, self)
  end

  def editable_by?(u)
    u == self
  end

  def destroyable_by?(u)
    u == self
  end
  
  # Mailing Lists Tools
  
  # def mailing_lists
  #   @mailing_lists ||= MailingLists.new(self)
  # end
  # 
  # def mailing_list_ids
  #   mailing_lists.ids
  # end
  # 
  # def mailing_list_ids=(value)
  #   mailing_lists.ids = value
  # end
  
  # Role Methods
  
  def self.with_role(name, obj = nil)
    includes(:roles).merge(Role.for(name, obj))
  end
  
  # Give the user this role.
  def has_role!(name, obj = nil)
    self.roles << Role[name, obj] unless has_role?(name, obj)
    true
  end

  # Check if the given user has this role
  def has_role?(name, obj = nil)
    roles.for(name, obj).exists?
  end

  # Remove a role from this user
  def remove_role!(name, obj = nil)
    roles.delete(Role[name, obj]) if has_role?(name, obj)
    true
  end

  
end
