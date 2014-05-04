require 'spec_helper'

describe Admin::SettingsController do

  before(:each) {@user = authenticate_user}

  let(:setting_created) {FactoryGirl.create(:setting)}

  context 'on list settings' do

    before(:each) {get :index}

    it 'render template' do
      expect(response).to be_success
    end

    it 'variable with list of settings' do
      expect(assigns(:settings)).to be_kind_of(Mongoid::Criteria)
    end

  end

end

