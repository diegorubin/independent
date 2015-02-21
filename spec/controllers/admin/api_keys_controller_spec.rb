require 'spec_helper'

describe Admin::ApiKeysController, type: :controller do

  let(:user_created) {FactoryGirl.create(:user)}
  before(:each) {@user = authenticate_user}


  context 'on create api key' do
    let(:api_key_attributes) { FactoryGirl.attributes_for(:api_key, user_id: '')}
    it 'associate user' do
      post :create, api_key: api_key_attributes
      expect(assigns(:api_key).user_id).to eql(@user.id.to_s)
    end

  end

end

