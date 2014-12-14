require 'spec_helper'

describe Admin::SettingsController, type: :controller do

  before(:each) {@user = authenticate_user}

  let(:setting_created) {FactoryGirl.create(:setting)}

  context 'on list settings' do

    before(:each) {get :index}

    it 'render template' do
      expect(response).to be_success
    end

    it 'variable with list of settings' do
      expect(assigns(:settings)).to be_kind_of(Hash)
    end

  end

  context 'on edit via ajax' do
    it 'response with success' do
      put :update, {id: setting_created.id, setting:{value: 'a'}, format: :json}
      setting_created.value = 'a'
      expect(response.body).to eql(setting_created.to_json)
    end
  end

end

