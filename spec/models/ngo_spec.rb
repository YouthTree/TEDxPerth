require 'spec_helper'

describe Ngo do

  describe "when checking validity" do

    it { should validate_presence_of :name }

    it { should validate_presence_of :url  }

    it { should_not allow_values_for :url, "google.com", " ", "42", :eh, "lulz" }

    it { should allow_values_for :url, "http://sutto.net", "http://google.com/a", "http://ted.com/awesome?yes=no" }

  end

  describe "mass assignment" do

    it { should allow_mass_assignment_of :name, :url, :description }

    it { should_not allow_mass_assignment_of :cached_slug, :state }

  end

  describe "marking representation" do
    
    before :each do
      @ngo    = Ngo.make!
      @user_a = User.make!
      @user_b = User.make!
      @user_c = User.make!
    end

    it "should let you mark someone as a representative" do
      @ngo.should_not be_represented_by(@user_a)
      @ngo.represented_by! @user_a
      @ngo.should be_represented_by(@user_a)
    end

    it "should let you remove someone as a representative" do
      @ngo.represented_by! @user_a
      @ngo.should be_represented_by(@user_a)
      @ngo.no_longer_represented_by! @user_a
      @ngo.should_not be_represented_by(@user_a)
    end

    it "should let you assign representative ids" do
      @ngo.should_not be_represented_by(@user_a)
      @ngo.should_not be_represented_by(@user_b)
      @ngo.should_not be_represented_by(@user_c)
      @ngo.representative_ids = [@user_a.id, @user_b.id]
      @ngo.should be_represented_by(@user_a)
      @ngo.should be_represented_by(@user_b)
      @ngo.should_not be_represented_by(@user_c)
    end

    it "should let you get representative ids" do
      @ngo.represented_by! @user_a
      @ngo.represented_by! @user_b
      @ngo.representative_ids.should == [@user_a.id, @user_b.id]
      @ngo.no_longer_represented_by! @user_a
      @ngo.representative_ids.should == [@user_b.id]
      @ngo.no_longer_represented_by! @user_b
      @ngo.representative_ids.should == []
    end

    it "should let you get a relation with all representatives" do
      @ngo.representatives.should be_instance_of(ActiveRecord::Relation)
      @ngo.representatives.all.should == []
      @ngo.represented_by! @user_a
      @ngo.represented_by! @user_b
      @ngo.representatives.all.should == [@user_a, @user_b]
      @ngo.no_longer_represented_by! @user_a
      @ngo.representatives.should == [@user_b]
      @ngo.no_longer_represented_by! @user_b
      @ngo.representatives.should == []
    end

    it "should let you get the associated representative role" do
      @ngo.representative_role.should be_instance_of(Role)
      @ngo.representative_role.owner.should == @ngo
      @ngo.representative_role.name.should == "representative"
    end

  end

  describe "the state of an ngo" do

    before :each do
      @ngo = Ngo.make!
    end

    it "should default to submitted" do
      @ngo.state.should == "submitted"
      @ngo.should be_submitted
    end

    it "should let you approve it" do
      @ngo.approve!
      @ngo.state.should == "approved"
      @ngo.should be_approved
    end

    it "should let you mark is as presented" do
      @ngo.approve!
      @ngo.present!
      @ngo.state.should == "presented"
      @ngo.should be_presented
    end

    it "should let you archive it" do
      @ngo.approve!
      @ngo.present!
      @ngo.archive!
      @ngo.state.should == "archived"
      @ngo.should be_archived
    end

  end

end

# == Schema Information
#
# Table name: ngos
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  url         :string(255)
#  cached_slug :string(255)
#  state       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#
