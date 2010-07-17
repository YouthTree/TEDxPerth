require 'spec_helper'

describe Admin::DashboardController do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

end
