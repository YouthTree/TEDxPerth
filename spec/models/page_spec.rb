require 'spec_helper'

describe Page do

  describe "validations" do

    it { should validate_presence_of :title }

    it { should validate_presence_of :content }

    it { should validate_presence_of :key }

  end

  describe "publishing pages" do

    it "should let you check if a post is published"

    it "should let you publish a post"

    it "should let you unpublish a post"

    it "should be unpublished if published_at is in the future"

    it "should let you get all published posts"

  end

  describe "scopes" do

    it "should let you get pages from a key"

    it "should let you find the home page"

    it "should let you get an optimized set of posts"

  end

  describe "converting content" do

    it "should automatically convert the content"

    it "should not convert the content when unchanged"

    it "should convert the content when it's format is changed"

    it "should convert the content when it's content is changed"

  end

  describe "slugs" do

    it "should automatically convert the title to a slug"

    it "should let you get posts with a slug"

    it "should let you get it based off of past slugs"

  end

end

# == Schema Information
#
# Table name: pages
#
#  id               :integer         not null, primary key
#  title            :string(255)
#  content          :text
#  rendered_content :text
#  published_at     :datetime
#  description      :text
#  keywords         :string(255)
#  key              :string(255)
#  cached_slug      :string(255)
#  format           :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#
