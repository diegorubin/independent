require 'spec_helper'

describe Admin::Api::V1::PostsController, type: :controller do

  context 'on not have key' do
    it('without key param') { get :index }
    it('invalid key') { get :index, api_key: 'xxxx' }
    after(:each) { expect(response.status).to eql(401) }
  end

  context 'on not have permission' do
    let(:api_key) { FactoryGirl.create(:api_key) }

    it('assign user') do 
      get :index, api_key: api_key.key 
      expect(assigns(:api_key)).to eql(api_key)
      expect(response.status).to eql(401)
    end

  end

  context 'on have permission' do
  end

end

