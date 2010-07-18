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

    it "should let you mark someone as a representative"

    it "should let you remove someone as a representative"

    it "should let you assign representative ids"

    it "should let you get representative ids"

    it "should let you get a scope with all representatives"

    it "should let you get the associated representative role"

  end

  describe "the state of an ngo" do

    it "should default to submitted"

    it "should let you approve it"

    it "should let you mark is as presented"

    it "should let you archive it"

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
