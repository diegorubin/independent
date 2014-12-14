require 'spec_helper'

describe FeedsController, type: :controller do
  before(:each) {clear_settings}

  describe "GET 'index'" do

    before(:each) {get 'index'}

    it "returns http success" do
      expect(response).to be_success
    end

    it 'array of items' do
      clear_list
      FactoryGirl.create(:post, published: true)
      expect(assigns(:list_items).count).to  eql(1)
    end

  end

end

