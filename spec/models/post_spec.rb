require 'spec_helper'

describe Post do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: posts
#
#  id               :integer(4)      not null, primary key
#  title            :string(255)
#  published_at     :datetime
#  rendered_summary :text
#  content          :text
#  rendered_content :text
#  format           :string(255)
#  preview_key      :string(255)
#  cached_slug      :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

