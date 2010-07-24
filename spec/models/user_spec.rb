require 'spec_helper'

describe User do
end

# == Schema Information
#
# Table name: users
#
#  id                :integer(4)      not null, primary key
#  login             :string(255)
#  crypted_password  :string(255)
#  password_salt     :string(255)
#  persistence_token :string(255)
#  email             :string(255)
#  login_count       :integer(4)
#  last_request_at   :datetime
#  last_login_at     :datetime
#  current_login_at  :datetime
#  last_login_ip     :string(255)
#  current_login_ip  :string(255)
#  display_name      :string(255)
#  origin            :string(255)
#  perishable_token  :string(255)     not null
#  cached_slug       :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

