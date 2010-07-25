require 'spec_helper'

describe Venue do
  pending "add some examples to (or delete) #{__FILE__}"
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

