require 'spec_helper'

describe Event do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: events
#
#  id                   :integer         not null, primary key
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

