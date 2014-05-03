require 'spec_helper'

describe Admin::WelcomeController do

  before(:each) {@user = authenticate_user}

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
