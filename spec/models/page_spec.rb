require 'spec_helper'
require 'shared/slugged_model'

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

    it "should let you get pages from an identifier" do
      page_a = Page.make!
      Page[page_a.key].should == page_a
      Page["some-random-key"].should be_nil
    end

    it "should let you find the home page" do
      Page.where(:key => "home").delete_all
      page = Page.make!(:key => "home")
      Page.home.should == page
    end
    
    it "should return a new home page if none exist" do
      Page.where(:key => "home").delete_all
      Page.home.should be_new_record
    end

    it "should let you get an optimized set of posts"

  end

  describe "converting content" do

    it "should automatically convert the content" do
      page = Page.new(:content => "Something", :format => 'markdown', :title => 'some-test-title', :key => 'testing')
      page.rendered_content.should be_blank
      page.save
      page.rendered_content.should == "<p>Something</p>"
    end

    it "should not convert the content when unchanged" do
      page = Page.make!(:content => "Something")
      dont_allow(page).send(:rendered_content=)
    end

    it "should convert the content when it's format is changed" do
      page = Page.make!(:content => "Something")
      page.format = "textile"
      mock(page).rendered_content = anything
      page.save
    end

    it "should convert the content when it's content is changed" do
      page = Page.make!(:content => "Something")
      page.content = "Something Else"
      mock(page).rendered_content = anything
      page.save
    end

  end

  describe "slugs" do

    it_should_behave_like 'a slugged model'
    
  end

end
# == Schema Information
#
# Table name: pages
#
#  id               :integer(4)      not null, primary key
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
#  menu_subtitle    :string(255)
#  menu_title       :string(255)
#  menu_position    :integer(4)
#  show_in_menu     :boolean(1)      default(FALSE)
#


# == Schema Information
#
# Table name: pages
#
#  id               :integer(4)      not null, primary key
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
#  menu_subtitle    :string(255)
#  menu_title       :string(255)
#  menu_position    :integer(4)
#  show_in_menu     :boolean(1)      default(FALSE)
#

